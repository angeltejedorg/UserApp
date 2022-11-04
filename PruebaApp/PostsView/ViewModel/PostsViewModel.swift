//
//  PostsViewModel.swift
//  PruebaApp
//
//  Created by angel.tejedore on 3/11/22.
//

import UIKit
import CoreData

class PostsViewModel {
    
    var postList: ObservableObject<[Post]?> = ObservableObject(nil)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getPostsList(userId: Int32) {
        networkService.fetchPosts { [weak self] posts in
            if let postsList = posts {
                self?.savePostData(postList: postsList, userId: userId)
            }
        }
    }
    
    func savePostData(postList: [PostEntity], userId: Int32) {
        
        postList.forEach { postItem in
            let newPost = Post(context: context)
            newPost.id = postItem.id
            newPost.userId = postItem.userId
            newPost.title = postItem.title
            newPost.body = postItem.body
        }
        do {
            try context.save()
            self.loadPostsData(userId: userId)
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadPostsData(userId: Int32) {
        
        let id = String(userId)
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        
        let predicate = NSPredicate(format: "userId MATCHES %@", id)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        do {
            postList.value = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func getPost(at index: Int) -> Post? {
        return postList.value?[index]
    }
}
