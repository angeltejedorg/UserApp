//
//  NetworkServiceImpl.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import Foundation
import Alamofire

class NetworkServiceImpl: NetworkServiceProtocol {

    
    func fetchUsers(completion: @escaping ([UserEntity]?) -> Void) {
        
        let url = "https://jsonplaceholder.typicode.com/users"
        let request = AF.request(url)
        
        request.responseDecodable(of: [UserEntity].self) { response in
            if response.error == nil, let users = response.value {
                completion(users)
            }
        }
    }
    
    func fetchPosts(completion: @escaping ([PostEntity]?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        let request = AF.request(url)
        
        request.responseDecodable(of: [PostEntity].self) { response in
            if response.error == nil, let posts = response.value {
                completion(posts)
            }
        }
    }
}
