//
//  FirestoreReferenceManager.swift
//  ReadTogether
//
//  Created by Александр on 15.02.2021.
//

import Firebase
import FirebaseFirestoreSwift

struct FirestoreReferenceManager {
    
    static let environment = "dev"
    //var uid = Login.currentUserID()
    static let db = Firestore.firestore()
    static let root = db.collection(environment).document(environment)
    
    static func referenceForUserBookCollectionOfCurrentUser(uid: String) -> CollectionReference {
        return root
            .collection(FirebaseKeys.CollectionPath.users)
            .document(uid)
            .collection(FirebaseKeys.CollectionPath.books)
    }
    
    static func referenceForAnnotations() -> CollectionReference {
        return root
            .collection(FirebaseKeys.CollectionPath.annotations)
    }
    
    static func referenceForAllUsers() -> CollectionReference {
        return root
            .collection(FirebaseKeys.CollectionPath.users)
    }
    
    static func referenceForUser(uid: String) -> DocumentReference {
        return root
            .collection(FirebaseKeys.CollectionPath.users)
            .document(uid)
    }
    
    static func getID() {
        print(Login.currentUserID())
    }
}
