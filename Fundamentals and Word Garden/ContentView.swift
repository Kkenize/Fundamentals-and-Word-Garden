//
//  ContentView .swift
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
import AVFAudio

struct ContentView: View {
    @State private static var maximumGuesses = 8
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var gameMessage = "How Many Guesses To Cover The Hidden Words?"
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var guessedLetter = ""
    @State private var lettersGuessed = ""
    @State private var guessesRemaining = maximumGuesses
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @State private var playAgainButtonLabel = "Another Word?"
    @State private var audioPlayer : AVAudioPlayer!
    @FocusState private var textFieldFocus: Bool
    private let wordsToGuess = ["SWIFT","DOG","CAT"]
      
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
                .frame(height: 100)
                .minimumScaleFactor(0.5)
                .padding()
            
//            blankSpaces = "_" + String(repeating: " _", count: wordsToGuess[currentWordIndex].count-1)
            
            Text(revealedWord)
                .font(.title)
            
//            blankSpaces = ""
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
                        .onSubmit {
                            guard guessedLetter != "" else { return }
                            guessALetter()
                            updateGameplay()
                        }
                    
                    Button("Guess a letter!") {
                        guessALetter()
                        updateGameplay()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
            } else {
                Button(playAgainButtonLabel) {
                    if currentWordIndex == wordToGuess.count {
                        currentWordIndex = 0
                        wordsGuessed = 0
                        wordsMissed = 0
                        playAgainButtonLabel = "Another Word?"
                    }
                    
                    wordToGuess = wordsToGuess[currentWordIndex]
                    
                    revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
                    lettersGuessed = ""
                    guessesRemaining = Self.maximumGuesses
                    imageName = "flower\(guessesRemaining)"
                    gameMessage = "How Many Guesses To Cover The Hidden Words?"
                    playAgainHidden = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .animation(.easeIn(duration: 0.75), value: imageName)
        }
        .ignoresSafeArea(edges:.bottom)
        .onAppear {
            wordToGuess = wordsToGuess[currentWordIndex]
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        }
    }
    
    func guessALetter() {
        textFieldFocus = false
        lettersGuessed = lettersGuessed + guessedLetter
        revealedWord = wordToGuess.map {
            letter in lettersGuessed.contains(letter) ? "\(letter)" : "_"
        }.joined(separator: " ")
    }
    
    func updateGameplay() {
        if !wordToGuess.contains(guessedLetter) {
            guessesRemaining -= 1
            imageName = "wilt\(guessesRemaining)"
            
            playSound(soundName: "incorrect")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                imageName = "flower\(guessesRemaining)"
            }
        } else {
            playSound(soundName: "correct")
        }
        
        if !revealedWord.contains("_") {
            gameMessage = "You've guessed it! It Took You \(lettersGuessed.count) Guesses to Guess the Word."
            wordsGuessed += 1
            currentWordIndex += 1
            playAgainHidden = false
            playSound(soundName: "word-guessed")
        } else if guessesRemaining == 0 {
            gameMessage = "So Sorry, You're All Out of Guesses!"
            wordsGuessed += 1
            currentWordIndex += 1
            playAgainHidden = false
            playSound(soundName: "word-not-guessed")
        } else {
            gameMessage = "You've Made \(lettersGuessed.count) Guess\(lettersGuessed.count == 1 ? "" : "es")"
        }
        
        if currentWordIndex == wordsToGuess.count {
            playAgainButtonLabel = "Restart Game?"
            gameMessage = gameMessage + "\nYou're Tried All of the Words. Restart from beginning?"
        }
        
        guessedLetter = ""
    }
    
    func playSound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("Can't find \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("\(error.localizedDescription)")
            return
        }
    }
}

#Preview {
    ContentView()
}
