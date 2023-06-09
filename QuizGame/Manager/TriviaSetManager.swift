//
//  TriviaSetManager.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-10.
//

import Foundation
import SwiftUI

class TriviaSetManager: ObservableObject {
    
    var triviaSetId = 2
    // Variables to set trivia and length of trivia
    private(set) var trivias: [Trivia] = []
    @Published private(set) var length = 0
    
    // Variables to set question and answers
    @Published private(set) var index = 0
    @Published private(set) var question: String = ""
    @Published private(set) var title: String = ""
    @Published private(set) var answerChoices: [Answer] = []
    
    // Variables for score and progress
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    
    // Variables to know if an answer has been selected and reached the end of trivia
    @Published private(set) var answerSelected = false
    @Published private(set) var reachedEnd = false
    
    // Call the fetchTrivia function on intialize of the class, asynchronously
    init() {
        Task.init {
            await fetchTrivia()
        }
    }
    
    // Asynchronous HTTP request to get the trivia questions and answers
    func fetchTrivia() async {

        
        do {

            let t = try await Webservice().load(TriviaSet.byId(triviaSetId))

            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false

                // Set new values for all variables
                self.title=t.title
                self.trivias = t.trivias
                self.length = self.trivias.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    // Function to go to next question. If reached end of the trivia, set reachedEnd to true
    func goToNextQuestion() {
        // If didn't reach end of array, increment index and set next question
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            // If reached end of array, set reachedEnd to true
            reachedEnd = true
        }
    }
    
    func reset() {
        
            reachedEnd = false

    }
    
    // Function to set a new question and answer choices, and update the progress
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)

        // Only setting next question if index is smaller than the trivia's length
        if index < length {
            let currentTriviaQuestion = trivias[index]
            question = currentTriviaQuestion.question
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    // Function to know that user selected an answer, and update the score
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        // If answer is correct, increment score
        if answer.correct ?? false {
            score += 1
        }
        

    }
}


