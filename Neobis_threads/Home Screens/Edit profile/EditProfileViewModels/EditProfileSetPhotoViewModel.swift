//
//  EditProfileSetPhoto.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 3/9/23.
//

import Foundation
import UIKit
import Alamofire

protocol SetProfilePhotoProtocol {
    var isSetData: Bool { get }
    var setDataResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func setPhoto(photoData: Data)
}

class EditProfileSetPhotoViewModel: SetProfilePhotoProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    var isSetData: Bool = false
    
    var setDataResult: ((Result<Data, Error>) -> Void)?
    
    func setPhoto(photoData: Data) {
        guard let token = AuthManager.shared.accessToken else {
            return
        }
        
        let parameters: [String: Any] = ["photo": photoData]
        
        apiService.patchPhoto(endpoint: "user/profile/me/edit_photo/", token: token, parameters: parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("Profile photo set successfully")
                    self?.isSetData = true
                    self?.setDataResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed to set profile photo: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isSetData = false
                    self?.setDataResult?(.failure(error))
                }
            }
        }
    }
}
