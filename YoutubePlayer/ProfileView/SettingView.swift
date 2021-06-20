//
//  SettingView.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/18.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct SettingView: View {
    @ObservedObject var userinfonow = FetchLoginUserInfo()
    @State var message: String = ""
    @State var role: String = ""
    @State var isdatachange: Bool = false
    @State var uiimage = UIImage()
    @State private var isShownPhotoLibrary: Bool = false
    @State var photoischange: Bool = false
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack {
            Form {
                HStack {
                    URLImageView(viewModel: .init(url: userinfonow.usermodel.profileImageUrl))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                    Text("->")
                    Button(action: {
                        self.isShownPhotoLibrary = true
                    }) {
                        Image(uiImage: self.uiimage)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fill)
                            .background(Color.gray)
                            .padding()
                    }
                }.sheet(isPresented: self.$isShownPhotoLibrary, content: {
                    SignInViewController(sourceType: .photoLibrary, selectImage: self.$uiimage)
                })
                TextField("Message", text: self.$message)
                    .padding()
                TextField("Role", text: self.$role)
                    .padding()
                Button(action: {
                    self.isdatachange = true
                    if (self.message != "" || self.role != "") {
                        self.updateprofile()
                    }
                    self.updatephotoUrl()
                    
                }) {
                    Text("アップデート")
                }.alert(isPresented: self.$isdatachange) {
                    Alert(title: Text("データの変更"),
                          message: Text("データの変更を反映しますか？"),
                          primaryButton: .destructive(Text("変更")),
                          secondaryButton: .cancel(Text("キャンセル"))
                    )
                    
                }.padding()
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }) {
                    Text("戻る")
                }
            }.navigationBarTitle(Text("Settings"))
            .onDisappear {
                self.userinfonow.fetchloginUserInfo()
            }
        }
    }
    
    private func updateprofile() {
        var doc: [String: Any] = [String: Any]()
        if (self.message.isEmpty && !self.role.isEmpty) {
            let docrole: [String: Any] = [
                "Role": self.role
            ]
            doc = docrole
        }
        else if (self.role.isEmpty && !self.message.isEmpty) {
            let docmessage: [String: Any] = [
                "Role": self.message
            ]
            doc = docmessage
        }
        else if(!self.role.isEmpty && !self.message.isEmpty) {
            let docfill: [String: Any] = [
                "Message": self.message,
                "Role": self.role
            ]
            doc = docfill
        }
        else {
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).setData(doc, merge: true) { error in
            if let error = error {
                print("Failed update data: \(error)")
                return
            }
            print("Success update data")
            self.message = ""
            self.role = ""
        }
    }
    
    private func updatephotoUrl() {
        guard let uploadImage = self.uiimage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profileImage")
            .child(fileName)
        storageRef.putData(uploadImage, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Failed saving data in firestorage: \(error)")
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed download url in firestore: \(error)")
                    return
                }
                guard let urlString = url?.absoluteString else { return }
                self.updateUserProfileImageinFireStore(profileImageUrl: urlString)
                
            }
        }
    }
    
    private func updateUserProfileImageinFireStore(profileImageUrl: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": profileImageUrl]) { (error) in
            if let error = error {
                print("Failed Update profileimage : \(error)")
                return
            }
            print("Sucess update profileimage")
            self.photoischange = true
            fetchUserinFireStore()
        }
    }
    
    private func fetchUserinFireStore() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid)
            .getDocument { (snapshot, error) in
                if let error = error {
                    print("Failed getting user data: \(error)")
                    return
                }
                guard let snapshot = snapshot else { return }
                guard let data = snapshot.data() else { return }
                print("\(data)")
                let user = UserModel(dic: data)
                self.userinfonow.usermodel = user
            }
        }

}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
