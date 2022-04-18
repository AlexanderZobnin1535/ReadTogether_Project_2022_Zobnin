//
//  MapView.swift
//  ReadTogether
//  Map View
//  Created by Александр on 17.12.2020.
//

import Foundation
import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation
import Combine

struct MapView: View {
    // the whole screen
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var userAnnotation = MKPointAnnotation()
    @State private var presentTestLibrary = false
    
    var body: some View {
        ZStack {
            MapViewDeclaration(centerCoordinate: $centerCoordinate, presentTestLibrary: $presentTestLibrary, annotation: userAnnotation)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color("Color"))
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.title = Auth.auth().currentUser?.email ?? "Error"
                        newLocation.coordinate = self.centerCoordinate
                        self.userAnnotation = newLocation
                        FirestoreReferenceManager.referenceForUser(uid: (Auth.auth().currentUser?.email!)!).setData([
                            "annotation" : GeoPoint(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
                        ], merge: true) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color("Color").opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $presentTestLibrary, content: {
            TestLibrary()
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct MapViewDeclaration : UIViewRepresentable {
    // the map itself
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewDeclaration
        
        init(_ parent: MapViewDeclaration) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? Annotation else {
                  return nil
                }
            let identifier = "user"
            var view : MKMarkerAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.animatesWhenAdded = true
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        // how annotations will look
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard (view.annotation as? Annotation) != nil else { return }
            parent.presentTestLibrary = true
        }
        // what should be done if 'i' is tapped
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @ObservedObject private var annotationsgetter = AnnotationsViewModel()
    
    @Binding var centerCoordinate : CLLocationCoordinate2D
    
    @Binding var presentTestLibrary : Bool
    
    var annotation: MKPointAnnotation
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        let region = CLLocationCoordinate2D(latitude: 55.791, longitude: 37.711617)
        map.setRegion(MKCoordinateRegion(center: region, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        // setting the start location
        
        return map
    }
    // making map
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)
        annotationsgetter.getAnnotations { (annotations) in
            if let annotations = annotations {
                view.addAnnotations(annotations)
            } else {
                print("Massive Error")
            }
        }
    }
    // downloading annotations from Firebase
}
