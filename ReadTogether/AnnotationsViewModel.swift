//
//  AnnotationsViewModel.swift
//  ReadTogether
//
//  Created by Александр on 30.03.2021.
//

import Foundation
import SwiftUI
import MapKit
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

class AnnotationsViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
        
    func getAnnotations(completion: @escaping (_ annotations: [MKAnnotation]?) -> Void) {

        FirestoreReferenceManager.referenceForAllUsers().addSnapshotListener { (querySnapshot, err) in
            
            guard let snapshot = querySnapshot
                else {
                    if let err = err {
                    print(err)
                    }
                    
                    completion(nil)
                    return
                }
            
            guard !snapshot.isEmpty
                else {
                    completion([])
                    return
                }
            
            var annotations = [MKAnnotation]()
            
            for document in snapshot.documents {
                  if let coords = document.get("annotation") as? GeoPoint {
                    // let annotation = MKPointAnnotation()
                    let annotation = Annotation(title: document.get("email") as? String, coordinate: CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude))
                    annotations.append(annotation)
                  }
            }
            //print(annotations)
            completion(annotations)
        }
    }
}

//document.get("coordinates")
//gets documents' field called "coordinates"
