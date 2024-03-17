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
    private var word: String = getRandomWord()
    
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
    private var gameRecordList: [GameRecord] = []
    
    var alphabet: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                              "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    

    var body: some View {
        ZStack {
            VStack {
                Text("Word Gueser")
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

            VStack {
                
                if (gameOver) {
                    if (isWin) {
                        Text("You Win! :)")
                            .offset(y: -10)
                    } else {
                        Text("You Lose :(")
                            .offset(y: -10)
                    }
                } else {
                    Text( "Select Letter to guess!")
                        .offset(y: -10)
                }
                
                SelectedLetters
            }
            .offset(y: 100)
            
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
                
                Button(action: {
                    wordVisible = !wordVisible
                }) {
                    Text(wordVisible || gameOver ? word : "Click to see word")
                }
                .offset(y: 100)
            }
            .offset(y: 240)

            
            if (gameOver) {
                Button("Play Again") {
                    resetGame()
                }
                .offset(y: 290)
            }
            
        }
    }
    
    var SelectedLetters: some View {
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
                        .frame(width: 24)
                        .background(guessedLetters.contains(letter) ? Color.gray : Color.clear)
                        .disabled(gameOver || guessedLetters.contains(letter))
                        
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
                        .frame(width: 24)
                        .background(guessedLetters.contains(letter) ? Color.gray : Color.clear)
                        .disabled(gameOver || guessedLetters.contains(letter))
                    }
                }
            }
            HStack {
                ForEach(alphabet, id: \.self) { letter in
                    if (alphabet.firstIndex(of: letter) ?? 0 > 19) {
                        Button(action: {
                            checkLetter(letter: letter)
                        }) {
                            Text(letter)
                                .font(.title)
                        }
                        .frame(width: 24)
                        .background(guessedLetters.contains(letter) ? Color.gray : Color.clear)
                        .disabled(gameOver || guessedLetters.contains(letter))
                    }
                }
            }
        }
    }
    
    
    func resetGame() {
        gameRecordList.append(GameRecord(id: UUID().uuidString,
                                         word: word,
                                         winLoss: isWin ? "W" : "L",
                                         strikes: strikeCount))
        guessedLetters = ""
        wordList = ["", "", "", "", "", ""]
        strikeList = ["", "", ""]
        strikeCount = 0
        hitCount =  0
        word = getRandomWord()
        gameOver = false
        isWin = false
        wordVisible = false
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
        if (strikeCount < 2) {
            strikeCount += 1
        } else {
            strikeCount += 1
            gameOver = true
        }
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
