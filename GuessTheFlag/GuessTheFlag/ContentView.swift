//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roberto Gutiérrez on 01/09/20.
//  Copyright © 2020 Roberto Gutiérrez. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth:  1))
        .shadow(color: .black, radius:  2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var playerScore = 0
    
    @State private var correctResponse = false
    @State private var animationAmount = 0.0
    
    @State private var flagTapped = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        withAnimation {
                            self.animationAmount += 360
                        }
                    
                    }) {
                        FlagImage(image: "\(self.countries[number])")
                            .rotation3DEffect(.degrees(self.correctResponse && number == self.correctAnswer ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                            .rotation3DEffect(.degrees(!self.correctResponse && self.flagTapped ? 45 : 0), axis: (x: 1, y: 0, z: 0))
                            .opacity(!(number == self.correctAnswer) && self.flagTapped ? 0.25 : 1)
                        
                        /*Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth:  1))
                            .shadow(color: .black, radius:  2)*/
                    }
                    .buttonStyle(PlainButtonStyle())
                
                }
                
                Section {
                    Text("Your current score is: \(playerScore)")
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(playerScore)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            correctResponse = true
            playerScore += 1
        } else {
            scoreTitle = "Wrong that's the flag of \(countries[number])"
            correctResponse = false
            playerScore -= 1
        }
        flagTapped = true
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flagTapped = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
