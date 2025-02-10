//
//  ContentView.swift
//  Fundamentals Two
//
//  Created by Zhejun Zhang on 2/9/25.
//

//Below are contents for Fundamentals Layout
//import SwiftUI
//
//struct ContentView: View {
//    @State private var messageString = ""
//    
//    var body: some View {
//        GeometryReader { geometry in
//            //        This is for setting background colors
//            //        ZStack {
//            //            Color.skyBlue
//            //                .ignoresSafeArea(edges: .all)
//            
//            VStack {
//                Text("You have skills!")
//                    .font(.largeTitle)
//                    .fontWeight(.black)
//                    .foregroundStyle(.white)
//                    .padding()
////                    .frame(width: .infinity)
//                    .background(.skyBlue)
//                    .clipShape(RoundedRectangle(cornerRadius: 40))
//                
//                Spacer()
//                
//                Text(messageString)
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                    .minimumScaleFactor(0.5)
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(.red)
//                    .frame(height: 150)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                //                .frame(width: 300, height: 150)
//                //                    .border(.orange, width: 2)
//                
//                Spacer()
//                Spacer()
//                Spacer()
//                
//                Divider()
//                    .background(.gray)
//                    .frame(width: geometry.size.width, height: 1)
//                
//                
//                HStack {
//                    Button("Awesome") {
//                        messageString = "You are awesome!"
//                    }
//                    
//                    Spacer()
//                    
//                    Button("Great") {
//                        messageString = "You are great!"
//                    }
//                }
//                .buttonStyle(.borderedProminent)
//                .padding()
//                
//// Sets the bottom safe area to skyBlue
//                Rectangle()
//                    .frame(height: 0)
//                    .background(.skyBlue)
//                
//            }
//            .padding()
//            .background(Gradient(colors: [.skyBlue, .green]))
//            //        }
//        }
//    }
//}

//Below are contents for Fundamentals Two Way Bindings
//import SwiftUI
//
//struct ContentView: View {
//    @State private var count = 0
//    @State private var toggleIsOn = true
//    @State private var textEntered = ""
//    @State private var colorSelected: Color = .red
//    @State private var dateSelected = Date()
//    @State private var stepperNumber = 1
//    @State private var sliderNumber = 50.0
//    
//    var body: some View {
//        VStack {
//            
//            Spacer()
//            Spacer()
//            
//            Text("Press Count: \(count)")
//                .font(.title2)
//            
//            Button("Add One") {
//                count += 1
//            }
//            .buttonStyle(.borderedProminent)
//            .font(.title2)
//            
//            Spacer()
//            
//            TextField("Enter a name:", text: $textEntered)
//                .textFieldStyle(.roundedBorder)
//            Text("Name Entered: \(textEntered)")
//            
//            Spacer()
//            
//            Toggle("Toggle is \(toggleIsOn ? "on" : "off"):", isOn: $toggleIsOn)
//            
//            Spacer()
//            
//            Rectangle()
//                .fill(colorSelected)
//                .frame(width: .infinity, height: 10)
//            ColorPicker("Please select a color:", selection: $colorSelected)
//            
//            Spacer()
//            
//            DatePicker("Please select a date:", selection: $dateSelected)
//            Text("Selected date is: \(dateSelected.formatted(date: .abbreviated, time: .shortened))")
//            
//            Spacer()
//            
//            Stepper("Stepper value: \(stepperNumber)", value: $stepperNumber, in: 1...10)
//            
//            Spacer()
//            
//            Slider(value: $sliderNumber, in: 0...100) {
//                //Accessibility Code
//            } minimumValueLabel: {
//                Image(systemName: "speaker.minus")
//                Text("0")
//            } maximumValueLabel: {
//                Image(systemName: "speaker.plus")
//                Text("100")
//            }
//            Text("Slider value is: \(String(format:"%.1f", sliderNumber))%")
//            
//            Spacer()
//        }
//    }
//}

//Below are contents for the word garden app
import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var wordsToGuess = ["SWIFT","DOG","CAT"]
    @State private var gameMessage = "How Many Guesses To Cover The Hidden Words?"
    @State private var currentWord = 0
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldFocus: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Words Guessed: \(wordsGuessed)")
                    Text("Words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Words to Guess: \(wordsToGuess.count - wordsGuessed - wordsMissed)")
                    Text("Words in Game: \(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
            Spacer()
            Text(gameMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("_ _ _ _ _")
                .font(.title)
            if playAgainHidden {
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) {
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else { return }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .focused($textFieldFocus)
                    Button("Guess a letter!") {
                        textFieldFocus = false
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
            } else {
                Button("Another Word?") {
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            } 
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges:.bottom)
        
    }
}

#Preview {
    ContentView()
}
