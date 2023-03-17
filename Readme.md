#  Readme
I. Initial Setup
   1. Add appIcon
      https://appicon.co 
      https://unsplash.com/t/food-drink
   2. Setup Accent Color
       https://medium.com/@priya_talreja/accentcolor-in-swiftui-setting-app-theme-58347682ba54  
       use the picker to select the color.
   3. Setup Config
      AppConfig.swift -> Target to NonTest
      AppConfigTest.swift -> Target to Test   
      https://stackoverflow.com/questions/54403857/ios-how-to-create-config-file-per-target 
   4. Setup Model
      https://quicktype.io
      TriviaItem.swift
   5. Setup Service
      NetworkService
   6. Setup TriviaCard View
      --preview sample data
   7. Setup ContentView             
      --preview sample data
      --Navigation View -Toolbar-NavigationLink
      https://developer.apple.com/documentation/swiftui/navigationlink
   8. Setup Manager 
       -1. QuickType TriviaSet by dataset from http://localhost:3000/api/ios/trivias/2
           Get TriviaSet,trivia,Answer
       -2. NetworkService : Extensins to URL, TriviaSet    
       -3. Add TriviaSetManager
       -4. Setup Trivia Manager in ContentView 
   9. Add Extensuions   
   10. Add components:PrimaryButton,progressBar, AnswerRow
   11. On Error Error fetching trivia: decodingError(class TriviaSetManager: ObservableObject {var triviaSetId = 2)
       Maybe change triviaSetId
    12. Image type of TriviaItem has the same name as View Image;  need to be add codingKeys to Types of TriviaItem triviaSet
    
    13.Add Trivia View
    14. Add QuestionView
    15. Add navigationLink to Home View 's TriviaItem
    
                            ForEach(trivias,id:\.id){ t in
                        
                                       NavigationLink {
                                          TriviaView()
                                               .environmentObject(triviaManager)
                                        } label: {
                                            TriviaCard(trivia: t)
                                        }
                    }


II.Submit App

How to publish Expo React Native App to Apple App Store (step-by-step tutorial)
https://www.youtube.com/watch?v=LE4Mgkrf7Sk&t=1s

1. xcode->Product->achive
2. Privacy Policy URL:
app.privacypolicies.com
3.Screen shot:
  5.5' ip8+
  6.5' ip14+

