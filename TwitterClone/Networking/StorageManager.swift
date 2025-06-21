//
//  StorageManager.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 28/11/23.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift
class   StorageManager {
    static let sharedInstance = StorageManager()
    let storage = Storage.storage()
        func getDownloadUrl(for id:String) -> AnyPublisher<URL, Error>{
            storage
                .reference(withPath: id)
                .downloadURL()
                .print()
                .eraseToAnyPublisher()
        }
    
        func uploadProfilePhoto(_ randomId:String, image: Data, metaData:StorageMetadata) -> AnyPublisher<StorageMetadata, Error>{
                storage
                .reference()
                .child("images/\(randomId).jpg")
                .putData(image, metadata: metaData)
                .print()
                .eraseToAnyPublisher()
            }
}
