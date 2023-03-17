//
//  TriviaSet.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-10.
//

import Foundation

import Foundation

// MARK: - Welcome
struct TriviaSet: Codable {
    let id: Int
    let image: [ImageUrl]
    let title: String
    let trivias: [Trivia]
}

// MARK: - Trivia
struct Trivia: Codable {
    let answers: [Answer]
    let id: Int
    let image: [ImageUrl]?
    let question: String
}

// MARK: - Answer
struct Answer: Codable {
    let correct: Bool?
    let id, text: String
}
