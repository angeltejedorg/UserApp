//
//  UserModel.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import Foundation

struct Users: Codable {
    let users: [UserEntity]
}

struct Posts: Codable {
    let posts: [PostEntity]
}

struct UserEntity: Codable {
    let id: Int32
    let name: String
    let email: String
    let phone: String
}

struct PostEntity: Codable {
    let id: Int32
    let userId: Int32
    let body: String
    let title: String
}
