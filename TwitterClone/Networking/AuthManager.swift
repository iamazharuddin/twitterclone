//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 22/08/23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine
class AuthManager {
     static let shared = AuthManager()
    
    func registerUser(with email:String, password:String) -> AnyPublisher<User, Error>{
      return  Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email:String, password:String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
