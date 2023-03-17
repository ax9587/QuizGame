//
//  TriviaCard.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-09.
//
import SwiftUI

struct TriviaCard: View {
    var trivia:TriviaItem
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: trivia.image[0].url),
                             transaction: .init(animation: .easeInOut(duration: 2)) ) { phase in
                    if let image = phase.image {
                      image // Displays the loaded image.
                        .resizable()
                        .cornerRadius(20)
                        .frame(width:175)
                        .scaledToFit()
                        .shadow(radius: 3)
                    } else if phase.error != nil {
                      Color.red // Indicates an error.
                    } else {
                      Color.blue // Acts as a placeholder.
                    }
                  }
                    
                
                //Text
                VStack(alignment: .leading){
                    Text(trivia.title)
                        .bold()
                }
                .padding()
                .frame(width: 175, alignment: .leading)
                .background(.ultraThinMaterial)//Blur bk
                .cornerRadius(20)
            }
            .frame(width:175,height: 240)

        }
    }
}

//struct TriviaCard_Previews: PreviewProvider {
//    static var previews: some View {
//        TriviaCard(trivia:productList[0])
//    }
//}

