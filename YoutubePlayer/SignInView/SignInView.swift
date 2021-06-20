//
//  SignInController.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/15.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State private var uiimage = UIImage()
    @State var isregsiter: Bool = true
    @State private var isShowPhotoLibrary: Bool = false
    @State private var allowtag: Bool = false
    
    var textfieldisEmpty: Bool {
        if (self.email.isEmpty || self.password.isEmpty || self.username.isEmpty) {
            return true
        }
        else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                Image(uiImage: self.uiimage)
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .background(Color.gray)
                .clipShape(Circle())
                .padding()
                .position(x: UIScreen.main.bounds.width/2, y: 150)
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.title3)
                    TextField("Emailを入力してください", text: $email)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width-50, height: 60)
                        .background(Color.gray)
                        .cornerRadius(15)
                }
                VStack(alignment: .leading) {
                    Text("Password")
                        .font(.title3)
                    TextField("Passwordを入力してください", text: $password)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width-50, height: 60)
                        .background(Color.gray)
                        .cornerRadius(15)
                }
                VStack(alignment: .leading) {
                    Text("UserName")
                        .font(.title3)
                    TextField("UserNameを入力してください", text: $username)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width-50, height: 60)
                        .background(Color.gray)
                        .cornerRadius(15)
                }
            }.position(x: UIScreen.main.bounds.width/2, y: 150)
            VStack {
                Button(action: {
                    tappedRegisterButton()
                }) {
                    Text("Regist")
                        .frame(width: 250, height: 25)
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.init(CGColor.init(red: 0, green: 185, blue: 0, alpha: 1)))
                .cornerRadius(15)
                .position(x: UIScreen.main.bounds.width/2, y: 90)
                .disabled(self.textfieldisEmpty)
                .fullScreenCover(isPresented: self.$allowtag) {
                    MainControllerView()
                }
                Link("Already have Account", destination: URL(string: "h")!)
                    .padding()
                    .position(x: UIScreen.main.bounds.width/2, y: 20)
                }
            
        }.sheet(isPresented: $isShowPhotoLibrary, content: {
            SignInViewController(sourceType: .photoLibrary, selectImage: self.$uiimage)
        })
        .onAppear {
            if Auth.auth().currentUser?.uid != nil {
                self.allowtag = true
            }
        }
    }
    
    private func tappedRegisterButton() {
        guard let uploadImage = self.uiimage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profileImage").child(fileName)
        
        storageRef.putData(uploadImage, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Failed saving data in firestorage: \(error)")
                return
            }
            print("Sucess saving data in firestorage")
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed download url in firestore: \(error)")
                    return
                }
                guard let urlString = url?.absoluteString else { return }
                self.createUserInfotoFireStore(profileImageUrl: urlString)
            }
        }
    }
    
    private func createUserInfotoFireStore(profileImageUrl: String) {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, error) in
            if let error = error {
                print("Failed saving auth infomation: \(error)")
                return
            }
            print("Success saiving auth infomation")
            guard let uid = res?.user.uid else { return }
            let docData: [String: Any] = [
                "email": email,
                "username": username,
                "createdAt": Timestamp(),
                "profileImageUrl": profileImageUrl,
                "friends": [UserModel]()
            ]
            Firestore.firestore().collection("users").document(uid).setData(docData) { (error) in
                if let error = error {
                    print("Failed saving data: \(error)")
                    return
                }
                print("Success saving data in firestore")
                self.allowtag = true
                self.email = ""
                self.password = ""
                self.username = ""
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
