//
//  ContentView.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-09.
//

import SwiftUI

struct ContentView: View {
    @State var trivias:[TriviaItem]=[]
    @StateObject var triviaManager = TriviaSetManager()
    var columns=[GridItem(.adaptive(minimum: 160),spacing: 20)]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns:columns,spacing: 20) {
                    ForEach(trivias,id:\.id){ t in
                        
                        NavigationLink {
                                          TriviaView(id:t.id)
                                               .environmentObject(triviaManager)
                                        } label: {
                                            TriviaCard(trivia: t)
                                        }
                    }
                }
                .task{
                    do{
                        trivias=try await Webservice().load(TriviaItem.all)
                    } catch{
                        print(error)
                    }
                }
                .refreshable {
                    do{
                        trivias=try await Webservice().load(TriviaItem.all)
                    } catch{
                        print(error)
                    }
                           }
                .padding()
            }
            .navigationTitle("Quizizi")
//            .toolbar {
//                NavigationLink {
//                    CartView()
//                        .environmentObject(cartManager)
//                } label: {
//                    CartButton(numberOfItems: cartManager.products.count)
//                }
//            }
        }
        .navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
