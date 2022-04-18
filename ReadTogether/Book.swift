//
//  Book.swift
//  ReadTogether
//
//  Created by Александр on 09.03.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Book: Identifiable, Codable {
  @DocumentID var id: String? = UUID().uuidString
  var title: String
  var author: String
  var numberOfPages: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case numberOfPages = "pages"
    }
}
