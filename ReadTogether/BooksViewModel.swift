//
//  BooksViewModel.swift
//  ReadTogether
//
//  Created by Александр on 09.03.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import Combine

class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    // var library = TestLibrary(person: true)
    
    var email = ""
    
    private var db = Firestore.firestore()
        
    func fetchData() {
        
        email = Auth.auth().currentUser?.email ?? ""
        FirestoreReferenceManager.referenceForUserBookCollectionOfCurrentUser(uid: email).addSnapshotListener { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.books = documents.compactMap { (queryDocumentSnapshot) -> Book? in
                
                return try? queryDocumentSnapshot.data(as: Book.self)

            }
        }
    }
}
