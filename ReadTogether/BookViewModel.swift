//
//  BookViewModel.swift
//  ReadTogether
//
//  Created by Александр on 11.03.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class BookViewModel: ObservableObject {
    
    @Published var book: Book
    
    var email = ""
    
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var db = Firestore.firestore()
    
    init(book: Book = Book(title: "", author: "", numberOfPages: 0)) {
        self.book = book
        
        self.$book
            .dropFirst()
            .sink { [weak self] book in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    func addBook(book: Book) {
        do {
            let user = Auth.auth().currentUser
            
            if let user = user {
                email = user.email!
                let _ = try FirestoreReferenceManager.referenceForUserBookCollectionOfCurrentUser(uid: self.email)
                    .addDocument(from: book)
            }
        }
        catch {
            print(error)
        }
    }
    
    func save() {
        addBook(book: book)
    }

}
