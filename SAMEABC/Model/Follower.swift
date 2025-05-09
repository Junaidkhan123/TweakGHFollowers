//
//  Follower.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 04/04/2025.
//


import Foundation
struct Follower: Codable {
    var login: String
    var avatarUrl: String
}

extension Follower {
    var avatarURL: URL? {
        URL(string: avatarUrl)
    }
}

extension Follower: Hashable { }
