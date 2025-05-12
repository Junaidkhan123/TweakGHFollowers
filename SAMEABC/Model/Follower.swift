//
//  Follower.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 04/04/2025.
//


import Foundation

struct Follower: Codable {
    let login: String
    let avatarUrl: URL?
}

extension Follower: Hashable { }

struct FollowerDTO: Decodable {
    let login: String
    let avatarUrl: String
}

final class FollowerEntityMaker {
    static func toFollower(from: FollowerDTO) -> Follower {
        Follower(login: from.login,
                 avatarUrl: URL(string: from.avatarUrl))
    }
}
