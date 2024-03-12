//
//  UserLoginModel.swift
//  CoffeeCofee
//
//  Created by 1 on 2023/08/14.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var userEmail: String = ""
    
    func UserLogin(email: String, password: String, showMainTabView: Binding<Bool>, completion: @escaping (Bool) -> Void) {
        
        self.userEmail = email
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                showMainTabView.wrappedValue = true
                completion(true)
            }
        }
    }
    
    func UserCreate(email: String, password: String) {
        
        self.userEmail = email
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                default:
                    errorMessage = error.localizedDescription
                }
            }
        }
        
    }
    
    func initializeUserID() -> String {
        
        let userUID: String
        
        if let user = Auth.auth().currentUser {
            userUID = user.uid
        } else {
            userUID = ""
        }
        
        return userUID
    }
}
