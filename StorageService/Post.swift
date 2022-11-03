//
//  Post.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import Foundation

public struct Post {
    public let author: String
    public let image: String
    public let text: String
    public let likes: Int
    public let views: Int
}

public var posts: [Post] = [
    Post(author: "IceFrog", image: "iceFrog", text: "Hi, i,m IceFrog, how are you today? I want to present to the world my new avatar, waiting for your likes. Kisses... <3", likes: 11, views: 100),
    Post(author: "CrazyFrog", image: "crazyFrog", text: "Hi, i,m CrazyFrog, how are you today? I want to present to the world my new avatar, waiting for your likes. Kisses... <3", likes: 15, views: 150),
    Post(author: "SimpleFrog", image: "simpleFrog", text: "Hi, i,m SimpleFrog, how are you today? I want to present to the world my new avatar, waiting for your likes. Kisses... <3", likes: 20, views: 200),
    Post(author: "LazyFrog", image: "lazyFrog", text: "Hi, i,m LazyFrog, how are you today? I want to present to the world my new avatar, waiting for your likes. Kisses... <3", likes: 25, views: 250),

]
