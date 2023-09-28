//
//  WriteViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/9/23.
//

import Foundation
import Alamofire

protocol WriteProtocol {
    var isSetData: Bool { get }
    var setDataResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func sendThread(text: String, image: Data, video: Data, comments_permission: String)
}

class WriteViewModel: WriteProtocol {
        
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    var isSetData = false
    
    var setDataResult: ((Result<Data, Error>) -> Void)?
        
    func sendThread(text: String, image: Data, video: Data, comments_permission: String) {
        guard let accessToken = AuthManager.shared.accessToken else { return }

        var request = URLRequest(url: URL(string: "https://pavel-backender.org.kg/post/")!)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        var body = Data()

        // Add text parameter
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"text\"\r\n\r\n")
        body.append(text)
        body.append("\r\n")

        // Add comments_permission parameter
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"comments_permission\"\r\n\r\n")
        body.append(comments_permission)
        body.append("\r\n")

        // Add image parameter
        if image != Data() {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(image)
            body.append("\r\n")
        }

        // Add video parameter
//        body.append("--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"video\"; filename=\"video.mp4\"\r\n")
//        body.append("Content-Type: video/mp4\r\n\r\n")
//        body.append(video)
//        body.append("\r\n")

        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            // Handle the response
            if let error = error {
                self?.setDataResult?(.failure(error))
                print(error)
                return
            }

            if let data = data {
                self?.isSetData = true
                self?.setDataResult?(.success(data))
                print(data)
            }
        }

        task.resume()
    }

}
