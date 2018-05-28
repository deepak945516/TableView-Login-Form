//
//  Model.swift
//  TableForm
//
//  Created by Deepak Kumar on 16/05/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import Foundation
import UIKit

let photoArray = [#imageLiteral(resourceName: "actors"), #imageLiteral(resourceName: "akshay"),#imageLiteral(resourceName: "amitabh"),#imageLiteral(resourceName: "deepika"),#imageLiteral(resourceName: "priyanka"),#imageLiteral(resourceName: "actors"),#imageLiteral(resourceName: "akshay"),#imageLiteral(resourceName: "amitabh"),#imageLiteral(resourceName: "deepika"),#imageLiteral(resourceName: "priyanka"),#imageLiteral(resourceName: "actors"),#imageLiteral(resourceName: "akshay"),#imageLiteral(resourceName: "amitabh"),#imageLiteral(resourceName: "deepika"),#imageLiteral(resourceName: "priyanka"),#imageLiteral(resourceName: "actors"),#imageLiteral(resourceName: "akshay"),#imageLiteral(resourceName: "amitabh"),#imageLiteral(resourceName: "deepika"),#imageLiteral(resourceName: "priyanka"),#imageLiteral(resourceName: "actors"),#imageLiteral(resourceName: "wallpaper")]
let nameArray = ["Actors", "Akshay Kumar", "Amitabh Bachchan", "Deepika Padukon", "Priyanka Chopra", "Actors", "Akshay Kumar", "Amitabh Bachchan", "Deepika Padukon", "Priyanka Chopra", "Actors", "Akshay Kumar", "Amitabh Bachchan", "Deepika Padukon", "Priyanka Chopra","Actors", "Akshay Kumar", "Amitabh Bachchan", "Deepika Padukon", "Priyanka Chopra", "Actors", "Akshay Kumar", "Amitabh Bachchan", "Deepika Padukon", "Priyanka Chopra", "Forest" ]

class User {
    var username: String = ""
    var password: String = ""
}

enum FormDataSource {
    case none
    case username
    case password
    
    static var allLoginFields = [username, password]
    
    static var user: User = User()
    
    var user: User {
        get {
            return FormDataSource.user
        }
        set {
            FormDataSource.user = newValue
        }
    }
    
    var title: String? {
        switch self {
        case .username: return "Username"
        case .password: return "Password"
        default: return nil
        }
    }
    
    var placeHolder: String? {
        switch self {
        case .username: return "Username"
        case .password: return "Password"
        default: return nil
        }
    }
    
    var value: String? {
        switch self {
        case .username: return user.username
        case .password: return user.password
        default: return nil
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .username: return .emailAddress
        default: return .default
        }
    }
    
    var returnKey: UIReturnKeyType {
        switch self {
        case .username:
            return .next
        case .password:
            return .done
        default:
            return .default
        }
    }
    
    var secureTextEntry: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .username:
            return #imageLiteral(resourceName: "username")
        case .password:
            return #imageLiteral(resourceName: "password_icon")
        default: return nil
        }
    }
}
