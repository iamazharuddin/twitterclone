//
//  ProfileDataFormViewModel.swift
//  TwitterClone
//
//  Created by Azharuddin 1 on 23/08/23.
//

import Foundation
import Foundation
import Combine
import UIKit
import FirebaseAuth
import FirebaseStorage


final class ProfileDataFormViewViewModel: ObservableObject {
    

    
    private var subscriptions: Set<AnyCancellable> = []
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var error: String = ""
    @Published var onBoardingState = false
    
    func validateUserProfileForm() {
        guard let displayName = displayName,
              displayName.count > 2,
              let username = username,
              username.count > 2,
              let bio = bio,
              bio.count > 2,
              imageData != nil else {
            isFormValid = false
            return
        }
        isFormValid = true
    }
    
    
    func uploadAvatar(){
        let randomID = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        StorageManager.sharedInstance.uploadProfilePhoto(randomID, image: imageData, metaData: metaData)
            .flatMap { metaData in
                StorageManager.sharedInstance.getDownloadUrl(for: metaData.path ?? "")
            }.sink { [weak self] completion in
                switch completion{
                case .failure(let error):
                    self?.error = error.localizedDescription
                case .finished:
                    print(self?.avatarPath ?? "")
                    self?.uploadUserData()
                }
            } receiveValue: { [weak self] url in
                self?.avatarPath = url.absoluteString
            }.store(in: &subscriptions)

    }
    
    
    private func uploadUserData(){
        guard let displayName, let username, let bio, let avatarPath, let id = Auth.auth().currentUser?.uid else { return }
        
        let updatedFileds : [String:Any] = [
            "displayName": displayName,
            "username": username,
            "bio" : bio,
            "avatarPath":avatarPath,
            "isUserOnboarded" : true
        ]
        
        DatabaseManager.shared.collectionUsers(updatedFields: updatedFileds, for : id)
            .sink { [weak self] completion in
            if case .failure(let error) = completion{
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] onBoardingState  in
            self?.onBoardingState = onBoardingState
        }.store(in: &subscriptions)

    }
        
}
