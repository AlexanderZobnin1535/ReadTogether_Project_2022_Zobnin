//  Profile View
//  Profile.swift
//  ReadTogether
//
//  Created by Александр on 17.12.2020.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import Foundation
import Firebase
import FirebaseFirestore

struct Profile: View {
    
    @State var color = Color(red: 0.282, green: 0.322, blue: 0.369, opacity: 1.0)
    var email = ""
    
    var body: some View {
        VStack {
            
            Text("Your email is " + getEmail())
                .padding()
            
            Text("Logged successfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(self.color)
            
            Button(action: {
                
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 15.0)
        }
    }
    func getEmail() -> String {
        let user = Auth.auth().currentUser
        let email = (user?.email)!
        return email
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

//document.get("coordinates")
//gets documents' field called "coordinates"
