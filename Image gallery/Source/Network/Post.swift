//
//  Post.swift
//  Image gallery
//
//  Created by Narek Matosyan on 16.02.2023.
//

import Foundation

struct PostUserProfileImage: Codable {
  let medium: String
}

struct PostUser: Codable {
  let profile_image: PostUserProfileImage
    
  let username: String
}

struct PostUrls: Codable {
  let regular: String
}

struct Post: Codable {
  let id: String
  let description: String?
  let created_at: String

  let user: PostUser
  let urls: PostUrls
}
