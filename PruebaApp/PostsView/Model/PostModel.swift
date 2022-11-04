//
//  PostModel.swift
//  PruebaApp
//
//  Created by angel.tejedore on 3/11/22.
//

import Foundation

struct PostEntity: Codable {
    let id: Int32
    let userId: Int32
    let body: String
    let title: String
}
