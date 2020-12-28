//
//  ContentView.swift
//  Challenge2
//
//  Created by Roberto Gutiérrez on 06/09/20.
//  Copyright © 2020 Roberto Gutiérrez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let playSelection = ["Rock", "Paper", "Scissors"]
    @State private var computerPlay = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var playResult = ""
    @State private var turnsLeft = 10
    @State private var showingScore = false
    
    var winCondition: String {
        if shouldWin {
            return "Win"
        } else {
            return "Lose"
        }
    }
    
    var body: some View {
        VStack(spacing:	 30) {
            Text("Rock, Paper, Scissors?")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            
            Section {
            Text("There are \(turnsLeft) turns left")
                .font(.largeTitle)
            Text("The computer has played")
            Text("\(playSelection[computerPlay])")
                .font(.largeTitle)
            Text("Your win condition is:")
            Text("\(winCondition)")
                .font(.largeTitle)
            }
            
            HStack(spacing: 30) {
                ForEach(0 ..< playSelection.count) { move in
                    Button(action: {
                        self.moveMade(move)
                    }) {
                        Text("\(self.playSelection[move])")
                            .foregroundColor(Color.green)
                            .font(.largeTitle)
                    }
                }
            }
            Spacer()
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Game Over"), message: Text("Your score is: \(playerScore)"), dismissButton: .default(Text("New Game?")) {
                self.newGame()
                })
        }
    }
    
    func moveMade(_ move: Int) {
        let computerMove = playSelection[computerPlay]
        let playerMove = playSelection[move]
        
        if computerMove == playerMove {
            playResult = "Draw"
        } else if computerMove == "Rock"{
            if playerMove == "Paper"{
                playResult = "Win"
            } else {
                playResult = "Lose"
            }
        } else if computerMove == "Paper" {
            if playerMove == "Scissors"{
                playResult = "Win"
            } else {
                playResult = "Lose"
            }
        } else if computerMove == "Scissors"{
            if playerMove == "Rock"{
                playResult = "Win"
            } else {
                playResult = "Lose"
            }
        }
        turnResult(playResult)
    }
    
    func turnResult(_ result: String) {
        if result == winCondition {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        askQuestion()
        turnsLeft -= 1
        if turnsLeft == 0 {
            showingScore = true
        }
    }
    
    func askQuestion() {
        computerPlay = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
    
    func newGame() {
        turnsLeft = 10
        playerScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
