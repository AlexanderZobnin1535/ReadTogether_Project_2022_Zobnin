//  LogIn&SignUp Views + Error View
//  FirstScreen.swift
//  ReadTogether
//
//  Created by Александр on 08.01.2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift

struct FirstScreen: View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    
    var body: some View{
        
        NavigationView {
            
            VStack{
                
                if self.status {
                    ContentView()
                } else {
                    
                    ZStack{
                        
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            
                            Text("")
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) {
                    (_) in
                    
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct Login : View {
    
    @State var email = ""
    @State var password = ""
    @State var color = Color(red: 0.282, green: 0.322, blue: 0.369, opacity: 1.0)
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    static var uid = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack(alignment: .topTrailing) {
                
                GeometryReader {_ in
                
                    VStack {
                Spacer()
                        
                //Image("Logo")
                    //.padding(.bottom)
                
                Text("ReadTogether")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(self.color)
                
                Text("Log in to your account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(self.color)
                    .padding(.top, 35)
                
                TextField("Email", text: self.$email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                    .padding(.top, 25.0)
                
                HStack(spacing: 15) {
                    
                    VStack {
                    
                        if self.visible{
                        
                            TextField("Password", text: self.$password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        
                        } else{
                        
                            SecureField("Password", text: self.$password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        
                        }
                    }
                    
                    Button(action: {
                        
                        self.visible.toggle()
                        
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                    }
                }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : self.color, lineWidth: 2))
                    .padding(.top, 25.0)
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.reset()
                        
                    }) {
                        
                        Text("Forgot your password?")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Color"))
                    }
                }
                .padding(.top, 15.0)
                
                Button(action: {
                    
                    self.verify()
                    
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 15.0)
                        
                Spacer()
            }
                    .padding(.horizontal, 25.0)
                }
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Text("Register")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Color"))
                }
                .padding()
            }
            
            if self.alert {
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    func verify() {
        if self.email != "" && self.password != "" {
            
            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, err) in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                Login.uid = self.email
                
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
        } else {
            
            self.error = "Please fill all the contents"
            self.alert.toggle()
        }
    }
    
    func reset() {
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email) {
                (err) in
                
                if err != nil {

                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        } else {
            
            self.error = "Enter your email"
            self.alert.toggle()
        }
    }
    
    static func currentUserID() -> String {
        return Login.uid
    }
    
}

struct SignUp : View {
    
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var color = Color(red: 0.282, green: 0.322, blue: 0.369, opacity: 1.0)
    @State var visible = false
    @State var repassword = ""
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    static var uid = ""
    
    var body: some View {
        
        ZStack{
            
            ZStack(alignment: .topLeading) {
                
                GeometryReader {_ in
                
                    VStack {
                Spacer()
                        
                //Image("Logo")
                    //.padding(.bottom)
                
                Text("ReadTogether")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(self.color)
                
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(self.color)
                    .padding(.top, 35)
                
                TextField("Email", text: self.$email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                    .padding(.top, 25.0)
                        
                TextField("Name", text: self.$name)
                    .disableAutocorrection(true)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.name != "" ? Color("Color") : self.color, lineWidth: 2))
                    .padding(.top, 25.0)
                
                HStack(spacing: 15) {
                    
                    //VStack {
                    
                        if self.visible{
                        
                            TextField("Password", text: self.$password)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        
                        } else{
                        
                            SecureField("Password", text: self.$password)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        
                        }
                    //}
                    
                    Button(action: {
                        
                        self.visible.toggle()
                        
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                    }
                }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : self.color, lineWidth: 2))
                    .padding(.top, 25.0)
                        
                HStack(spacing: 15) {
                            
                            //VStack {
                            
                                if self.revisible{
                                
                                    TextField("Confirm your password", text: self.$repassword)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                
                                } else{
                                
                                    SecureField("Confirm your password", text: self.$repassword)
                                        .disableAutocorrection(true)
                                        .autocapitalization(.none)
                                
                                }
                            //}
                            
                            Button(action: {
                                
                                self.revisible.toggle()
                                
                            }) {
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                            }
                        }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.repassword != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25.0)
                
                Button(action: {
                    
                    self.register()
                    
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("Color"))
                .cornerRadius(10)
                .padding(.top, 15.0)
                        
                Spacer()
            }
                    .padding(.horizontal, 25.0)
                }
                
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("Color"))
                }
                .padding()
            }
            
            if self.alert {
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func register() {
        
        if self.email != "" {
            
            if self.password == self.repassword {
                
                if self.name != "" {
                
                Auth.auth().createUser(withEmail: self.email, password: self.password) {
                    (res, err) in
                    
                    if err != nil {
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return //22:30
                    } else {
                    
                    let userData = [
                        "name" : self.name,
                        "email" : self.email,
                        "annotation" : nil
                    ]
                    
                    let currentUser = FirestoreReferenceManager.root.collection(FirebaseKeys.CollectionPath.users)
                        .document(self.email)
                        SignUp.uid = currentUser.documentID
                        
                        FirestoreReferenceManager.root.collection(FirebaseKeys.CollectionPath.users)
                            .document(self.email)
                            .setData(userData as [String : Any])

                    print("success")
                        
                    self.show.toggle()
                        }
                    }
                } else {
                    self.error = "Enter your name"
                    self.alert.toggle()
                }
            } else {
                
                self.error = "Password was not confirmed"
                self.alert.toggle()
            }
        } else {
            
            self.error = "Enter your email"
            self.alert.toggle()
        }
    }
}

struct ErrorView : View {
    
    @State var color = Color(red: 0.282, green: 0.322, blue: 0.369, opacity: 1.0)
    @Binding var alert : Bool
    @Binding var error : String
    
    var body : some View {
        
        GeometryReader {_ in
            VStack {
                Spacer()
                HStack {
                    Spacer()
            VStack {
                
                HStack {
                    
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25.0)
                
                Text(self.error == "RESET" ? "Password reset link has been sent on your email" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25.0)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                }) {
                    Text(self.error == "RESET" ? "OK" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color("Color"))
                .cornerRadius(10.0)
                .padding(.top, 25)
            }
            .padding(.horizontal, 25.0)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15.0)
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
