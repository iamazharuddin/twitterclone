//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 23/08/23.
//

import Foundation
import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine



class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    
    let db = Firestore.firestore()
    let usersPath: String = "users"
    
    
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    
    func collectionUsers(retreive id: String) -> AnyPublisher<TwitterUser, Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap { try $0.data(as: TwitterUser.self) }
            .eraseToAnyPublisher()
    }

    
    func collectionUsers(updatedFields:[String:Any], for id:String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).updateData(updatedFields).map({ _ in
            return true
        }).eraseToAnyPublisher()
    }
    
}
