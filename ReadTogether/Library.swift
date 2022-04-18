//
//  Library.swift
//  ReadTogether
//
//  Created by Александр on 11.01.2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
//import Combine


struct Library: View {
    
    //@ObservedObject private var annotationViewModel = AnnotationsViewModel()
    //@State var annotations = ""
    
    var body: some View {

        VStack {
        Button(action: {

            //playground
            
            /*FirestoreReferenceManager.root
                .collection(FirebaseKeys.CollectionPath.cities)
                .document("NA")
                .setData(["name": "Los Angeles",
                          "state": "CA",
                          "country": "USA",
                          "favorites": [ "food": "Pizza", "color": "Blue", "subject": "recess"]
                ]) { (err) in
                    if let err = err {
                        print(err.localizedDescription)
                    }
                    print("Data added successfully")
                }*/
            
            //userData below
            
            FirestoreReferenceManager.getID()
            
            /*let reference = FirestoreReferenceManager.root.collection(FirebaseKeys.CollectionPath.users).addDocument(data: ["number" : 1])
            
            let uid = reference.documentID
            
            let userData = [
                "uid": uid,
                "name": "Bob"
            ]
            
            FirestoreReferenceManager.referenceForUserPublicData(uid: uid).setData(userData, merge: true) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                }
                print("userData added successfully")
            }*/
            
        }) {
            Text("Print UserID (only recently logged in)")
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 120)
        }
        .background(Color("Color"))
        .cornerRadius(10.0)
        .padding(.top, 25)
        
            Button(action: {

                let userID : String = (Auth.auth().currentUser?.uid)!
                    print("Current user ID is " + userID)
                //check authentication tab in firebase for what is UID
                
            }) {
                Text("Get current user ID")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(Color("Color"))
            .cornerRadius(10.0)
            .padding(.top, 25)
            
            Button(action: {

                let user = Auth.auth().currentUser
                
                if let user = user {
                    let email = user.email

                    print("Current user email is " + email!)
                }
                
            }) {
                Text("Get current user email")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(Color("Color"))
            .cornerRadius(10.0)
            .padding(.top, 25)
            
            Button(action: {
                
                FirestoreReferenceManager.root
                    .collection(FirebaseKeys.CollectionPath.users).getDocuments() {
                        (querySnapshot, err) in
                        if let err = err {
                            print(err.localizedDescription)
                        }
                        for document in querySnapshot!.documents {
                            print(document.documentID)
                        }
                    }
                
            }) {
                Text("Print all accs")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(Color("Color"))
            .cornerRadius(10.0)
            .padding(.top, 25)
            
            Button(action: {
                
                //FirestoreReferenceManager.referenceForBooks().addDocument(data: ["data" : "trying"])
                
            }) {
                Text("Print coordinates XXX")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 120)
            }
            .background(Color("Color"))
            .cornerRadius(10.0)
            .padding(.top, 25)
            
            //Text(annotations)
            
            /*List {
                ForEach (annotationViewModel.annotations) { annotation in
                BookRow(annotation: annotation)
                }
            }*/
            
            Spacer()
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}


//let cityData = [ "name": "Los Angeles New" ]
//...
//.setData(cityData, merge: true)
//to add data, not change it – use "merge: true"

//1st March report...


/*Button(action: {
    
    let docRef = FirestoreReferenceManager.root
        .collection(FirebaseKeys.CollectionPath.cities)
        .document("LA")

    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
        } else {
            print("Document does not exist")
        }
    }
    
}) {
    Text("Don't touch!")
        .foregroundColor(.red)
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width - 120)
}
.background(Color("Color"))
.cornerRadius(10.0)
.padding(.top, 25)*/

/*Button(action: {
    
    let ref = FirestoreReferenceManager.root
        .collection(FirebaseKeys.CollectionPath.cities)
        .document("LA")
    
    ref.updateData(["name": "Los Angeles Updated",
                    "favorites.color": "Green",
                    "updatedAt": FieldValue.serverTimestamp(),
                    "regions": FieldValue.arrayRemove(["greater_virginia"])]) { (err) in
        if let err = err {
            print(err.localizedDescription)
        }
        print("cityData updated successfully")
    }
    
}) {
    Text("Update")
        .foregroundColor(.white)
        .padding(.vertical)
        .frame(width: UIScreen.main.bounds.width - 120)
}
.background(Color("Color"))
.cornerRadius(10.0)
.padding(.top, 25)*/
