//
//  TextViewController.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/15.
//

import SwiftUI

struct TextViewController: UIViewRepresentable {
    typealias UIViewType = UITextField
    @Binding private var emailtext: String
    @Binding private var passwordtext: String
    @Binding private var usernametext: String
    @Binding var isregister: Bool
    private let textField = UITextField()
    private var label: String
    
    init(_ label: String, emailtext: Binding<String>,passwordtext: Binding<String>, usernametext: Binding<String>, isregister: Binding<Bool>) {
        self.label = label
        self._emailtext = emailtext
        self._passwordtext = passwordtext
        self._usernametext = usernametext
        self._isregister = isregister
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(textField: self.textField, emailtext: self._emailtext,passwordtext: self._passwordtext, usernametext: self._usernametext,isregister: self._isregister)
    }
    
    func makeUIView(context: Context) -> UITextField {
        textField.placeholder = self.label
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.$emailtext.wrappedValue
    }
}

extension TextViewController {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var emailtext: String
        @Binding var passwordtext: String
        @Binding var usernametext: String
        @Binding var isregister: Bool
        
        init(textField: UITextField, emailtext: Binding<String> , passwordtext: Binding<String>, usernametext: Binding<String>, isregister: Binding<Bool>) {
            self._emailtext = emailtext
            self._isregister = isregister
            self._passwordtext = passwordtext
            self._usernametext = usernametext
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            print("\(textField)")
            let emailtextfieldisEmpty = !emailtext.isEmpty
            let passwordtextfieldisEmpty = !passwordtext.isEmpty
            let usernametextfieldisEmpty = !usernametext.isEmpty
            print("\(emailtextfieldisEmpty)")
            
            if (emailtextfieldisEmpty || passwordtextfieldisEmpty || usernametextfieldisEmpty) {
                self.isregister = true
            }
            else if (emailtextfieldisEmpty && passwordtextfieldisEmpty && usernametextfieldisEmpty){
                self.isregister = false
                
            }
        }
    }
}
