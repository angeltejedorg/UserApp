//
//  NetworkServiceProtocol.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func fetchUsers(completion: @escaping ([UserEntity]?) -> Void)
    
    func fetchPosts(completion: @escaping ([PostEntity]?) -> Void)
}
