//
//  ContentView.swift
//  SENG-5199-Assignment3
//
//  Created by Moti Begna on 3/16/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State
    private var guessedLetters: String = ""
        
    @State
    private var word: String
    
    @State
    private var hint: String

    @State
    private var wordList: [String] = ["", "", "", "", "", ""]
    
    @State
    private var strikeList: [String] = ["", "", ""]
    
    @State
    private var strikeCount: Int = 0
    
    @State
    private var hitCount: Int = 0
    
    @State
    private var gameOver: Bool = false
    
    @State
    private var isWin: Bool = false
    
    @State
    private var wordVisible: Bool = false
    
    @State
    private var hintVisible: Bool = false
    
    @State 
    private var scale = 1.0
    
    @State
    private var gameRecordList: [GameRecord] = []
    
    var alphabet: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                              "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    init (){
        let wordHint: (key: String, value: String) = getRandomWord()
        word = wordHint.value
        hint = wordHint.key
    }
    
    var body: some View {
        ZStack {
            HeaderView
            GuessView
            ResultView
            SelectorView
            StrikeView
            HintView
            
            if (gameOver) {
                Button("Play Again") {
                    resetGame()
                }
                .offset(y: 270)
            }
            
        }
    }
    
    var HeaderView: some View {
        VStack {
            Text("Word Guesser")
                .font(.title)
            Text("Game Record")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top, 10)
            ScrollView {
                ForEach(gameRecordList) { gameRecord in
                    HStack {
                        Text("Word: \(gameRecord.word)")
                        Text("Result: \(gameRecord.winLoss)")
                        Text("Strikes: \(gameRecord.strikes)")
                    }
                }
            }
            .frame(height: 100)
        }
        .offset(y: -280)
    }
    
    var GuessView: some View {
        HStack {
            GroupBox() {
                Text(wordList[0])
            }
            GroupBox() {
                Text(wordList[1])
            }
            GroupBox() {
                Text(wordList[2])
            }
            GroupBox() {
                Text(wordList[3])
            }
            GroupBox() {
                Text(wordList[4])
            }
        
        }
        .offset(y: -70)
    }
    
    var ResultView: some View {
        VStack {
            if (gameOver) {
                if (isWin) {
                    if (strikeCount == 0) {
                        Text("No Strikes!")
                            .font(.system(size: 36))
                            .frame(width: 200, height: 200)
                            .scaleEffect(scale)
                            .onAppear {
                                let baseAnimation = Animation.easeInOut(duration: 1)
                                let repeated = baseAnimation.repeatCount(5, autoreverses: true)

                                withAnimation(repeated) {
                                    scale = 0.5
                                }
                            }
                    } else {
                        Text("You Win! :)")
                    }
                } else {
                    Text("You Lose :(")
                }
            } else {
                Text("Select letter to guess")
            }
        }
        .offset(y: 10)
    }
    
    var SelectorView: some View {
        VStack {
            HStack {
                ForEach(alphabet, id: \.self) { letter in
                    if (alphabet.firstIndex(of: letter) ?? 0 <= 9) {
                        Button(action: {
                            checkLetter(letter: letter)
                        }) {
                            Text(letter)
                                .font(.title)
                        }
                        .frame(width: 28)
                        .background(guessedLetters.contains(letter) ? Color.gray : Color.clear)
                        .disabled(gameOver || guessedLetters.contains(letter))
                        .border(Color.gray, width: 1)

                    }
                }
            }
            HStack {
                ForEach(alphabet, id: \.self) { letter in
                    if (alphabet.firstIndex(of: letter) ?? 0 > 9 && alphabet.firstIndex(of: letter) ?? 0 <= 19) {
                        Button(action: {
                            checkLetter(letter: letter)
                        }) {
                            Text(letter)
                                .font(.title)
                        }
                        .frame(width: 28)
                        .background(guessedLetters.contains(letter) ? Color.gray : Color.clear)
                        .disabled(gameOver || guessedLetters.contains(letter))
                        .border(Color.gray, width: 1)
                    }
                }
            }
            .offset(y: 10)
            HStack {
                ForEach(alphabet, id: \.self) { letter in
                    if (alphabet.firstIndex(of: letter) ?? 0 > 19) {
                        Button(action: {
                            checkLetter(letter: letter)
                        }) {
                            Text(letter)
                                .font(.title)
                        }
                        .frame(width: 28)
                        .background(guessedLetters.contains(letter) ? Color.gray : Color.clear)
                        .disabled(gameOver || guessedLetters.contains(letter))
                        .border(Color.gray, width: 1)
                    }
                }
            }
            .offset(y: 20)
        }
        .offset(y: 100)
    }
    
    var StrikeView: some View {
        VStack {
            HStack {
                GroupBox() {
                    Text(strikeList[0])
                }
                .backgroundStyle(strikeList[0] == "X" ? Color.red : strikeList[0] == "W" ? Color.green : Color.gray)
                GroupBox() {
                    Text(strikeList[1])
                }
                .backgroundStyle(strikeList[1] == "X" ? Color.red : strikeList[1] == "W" ? Color.green : Color.gray)
                GroupBox() {
                    Text(strikeList[2])
                }
                .backgroundStyle(strikeList[2] == "X" ? Color.red : strikeList[2] == "W" ? Color.green : Color.gray)
                
            }
        }
        .offset(y: 220)
    }
    
    var HintView: some View {
        VStack {
            Button(action: {
                hintVisible = !hintVisible
            }) {
                Text(hintVisible ? hint : "Click to see hint")
            }
            .disabled(gameOver)
            .offset(y: -20)
            
            Button(action: {
                wordVisible = !wordVisible
            }) {
                Text(wordVisible ? word : "Click to see word")
            }
            .disabled(gameOver)
        }
        .offset(y: 340)
    }
    
    
    func resetGame() {
        let wordHint: (key: String, value: String) = getRandomWord()
        word = wordHint.value
        hint = wordHint.key
        
        guessedLetters = ""
        wordList = ["", "", "", "", "", ""]
        strikeList = ["", "", ""]
        strikeCount = 0
        hitCount =  0
        scale = 1.0
        gameOver = false
        isWin = false
        wordVisible = false
        hintVisible = false
    }
    
    func checkLetter(letter: String) {
        var found = false
        if (guessedLetters != "") {
            guessedLetters += ", " + letter
        } else {
            guessedLetters = letter
        }
        
        for (index, char) in word.enumerated() {
            if (letter == String(char).uppercased()) {
                wordList[index] = letter
                hitCount += 1
                if (hitCount == 5) {
                    gameOver = true
                    isWin = true
                    addGameRecord()
                    for i in 0...2 {
                        if (strikeList[i] != "X") {
                            strikeList[i] = "W"
                        }
                    }
                }
                found = true
            }
        }
        
        if (found) {
            return
        }
        
        strikeList[strikeCount] = "X"
        strikeCount += 1
        if (strikeCount == 3) {
            gameOver = true
            addGameRecord()
            for (index, char) in word.enumerated() {
                wordList[index] = String(char).uppercased()
            }
        }
    }
    
    func addGameRecord() {
        gameRecordList.append(GameRecord(id: UUID().uuidString,
                                         word: word,
                                         winLoss: isWin ? "W" : "L",
                                         strikes: strikeCount))
    }
    
    struct GameRecord: Identifiable {
        var id: String
        
        let word: String
        let winLoss: String
        let strikes: Int
    }
}


#Preview {
    ContentView()
}
