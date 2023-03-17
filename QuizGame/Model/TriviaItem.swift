//
//  TriviaItem.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-09.
//

import Foundation

// MARK: - Welcome
struct TriviaItem: Codable {
    let id: Int
    let image: [ImageUrl]
    let title: String

}

// MARK: - Image
struct ImageUrl: Codable {
    let url: String
}
