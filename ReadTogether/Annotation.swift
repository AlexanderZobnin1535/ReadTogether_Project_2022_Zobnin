//
//  Annotation.swift
//  ReadTogether
//
//  Created by Александр on 30.03.2021.
//

import Foundation
import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

class Annotation: NSObject, MKAnnotation {
    
     var title: String?
     @objc dynamic var coordinate: CLLocationCoordinate2D
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D
      ) {
        self.title = title
        self.coordinate = coordinate

        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case title
    }
}
