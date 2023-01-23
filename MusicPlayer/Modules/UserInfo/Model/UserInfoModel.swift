//
//  UserInfoModel.swift
//  MusicPlayer
//
//  Created by Артем Галай on 19.01.23.
//

import UIKit

struct User {
    let username: String
    let email: String
    let userUID: String
}

struct UserInfoModel {
    static let categories: [String] = ["Name", "Email", "Language", "Privacy", "Storage", "Audio Quality"]
}
