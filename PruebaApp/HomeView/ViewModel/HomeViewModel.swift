//
//  HomeViewModel.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import UIKit
import CoreData

class HomeViewModel {
    
    var usersList: ObservableObject<[User]?> = ObservableObject(nil)
    var filteredUserList: ObservableObject<[User]?> = ObservableObject(nil)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getUsersList() {
        print("being called")
        networkService.fetchUsers { [weak self] users in
            if let userList = users {
                self?.saveUserData(userList: userList)
            }
        }
    }
    
    func saveUserData(userList: [UserEntity]) {
        
        userList.forEach { userItem in
            let newUser = User(context: context)
            newUser.id = userItem.id
            newUser.name = userItem.name
            newUser.email = userItem.email
            newUser.phone = userItem.phone
        }
        do {
            try context.save()
            self.loadData()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
  
    func loadData() {
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            usersList.value = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func searchUser(_ text: String) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        do {
            filteredUserList.value = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func setFilteredUsers(_ filteredUsers: [User]) {
        usersList.value = filteredUsers
    }
    
    func deleteItem(index: Int) {
        
        guard let userList = usersList.value  else { return }
        context.delete(userList[index])
        usersList.value?.remove(at: index)
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func getUser(at index: Int) -> User? {
        return usersList.value?[index]
    }
}
