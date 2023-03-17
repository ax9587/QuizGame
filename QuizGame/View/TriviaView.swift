//
//  TriviaView.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-10.
//
import SwiftUI

struct TriviaView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>  //dismiss views
    @EnvironmentObject var triviaManager: TriviaSetManager
    var id=2
    var body: some View {
        
        if triviaManager.reachedEnd {
            VStack(spacing: 20) {
                Text("Trivia Game")
                    .lilacTitle()

                Text("Congratulations, you completed the game! 🥳")
                
                Text("You scored \(triviaManager.score) out of \(triviaManager.length)")
                
                Button {
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                } label: {
                    PrimaryButton(text: "Play again")
                }
                Button {
                    Task.init {
                        triviaManager.reset()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    PrimaryButton(text: "Go Back")
                }
               ////dismiss views
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .navigationBarHidden(true)
        } else {
            
            QuestionView()
                .environmentObject(triviaManager)
                .task{
                    do{
                        triviaManager.triviaSetId=id
                        await triviaManager.fetchTrivia()
                    } catch{
                        print(error)
                    }
                }
        }
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaSetManager())
    }
}
