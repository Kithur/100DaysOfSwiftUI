//
//  ContentView.swift
//  Challenge3
//
//  Created by Roberto Gutiérrez on 16/09/20.
//  Copyright © 2020 Roberto Gutiérrez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isGameStarted = false
    @State private var multiplicationTable = 2
    @State private var multiplicationTable2 = 0
    @State private var multiplicationTable3 = 0
    
    let questionSelection = ["5", "10", "20", "All"]
    @State private var numberOfQuestions = 2
    
    @State private var questionsArray = [String]()
    @State private var tablesArray = [String]()
    
    @State private var currentQuestion = 1
    @State private var answer = ""
    @State private var score = 0
    @State private var questions = 0
    @State private var isGameOver = false
    
    var number1: Int {
        let question = questionsArray[currentQuestion]
        let numberString = question[question.startIndex]
        let numberString2 = String(numberString)
        let number = Int(numberString2) ?? 1
        return number
    }
    
    var number2: Int {
        let question = questionsArray[currentQuestion]
        if question.count <= 3 {
            let numberString = question[question.index(question.startIndex, offsetBy: 2)]
            let numberString2 = String(numberString)
            let number = Int(numberString2) ?? 1
            return number
        } else {
            return 10
        }
    }
    
    var questionsSelected: Int {
        let number = Int(questionSelection[numberOfQuestions]) ?? 5
        return number
    }
    
    var body: some View {
        NavigationView {
            Group {
                if isGameStarted == false {
                        Form {
                            Section(header: Text("Which multiplication table do you want to practice?")) {
                                Stepper(value: $multiplicationTable, in: 1...10) {
                                    Text("The number \"\(multiplicationTable)\" table")
                                }
                            }
                            
                            Section(header: Text("Do you want to practice another table as well?")) {
                                Stepper(value: $multiplicationTable2, in: 0...10) {
                                    if multiplicationTable2 == 0 {
                                        Text("Not now")
                                    } else {
                                    Text("The number \(multiplicationTable2) table")
                                    }
                                }
                            }
                            
                            Section(header: Text("What about a third one?")) {
                                Stepper(value: $multiplicationTable3, in: 0...10) {
                                    if multiplicationTable3 == 0 {
                                        Text("Not now")
                                    } else {
                                        Text("The number \(multiplicationTable3) table")
                                    }
                                }
                            }
                            
                            Section(header: Text("How many questions should be asked?")) {
                                Picker("Number of Questions", selection: $numberOfQuestions) {
                                    ForEach(0 ..< questionSelection.count) {
                                        Text("\(self.questionSelection[$0])")
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            Button("Start Practice") {
                                self.startGame(first: self.multiplicationTable, second: self.multiplicationTable2, third: self.multiplicationTable3)
                            }
                        }
                    } else if isGameStarted == true {
                    Form {
                        Text("How much is \(number1) times \(number2)")
                            .font(.largeTitle)
                        
                        Section() {
                            TextField("Your Answer", text: $answer)
                                .keyboardType(.decimalPad)
                        }
                        
                        Button("Evaluate") {
                            self.evaluate()
                        }
                        
                        Text("Your current score is: \(score)")
                    }
                    onAppear(perform: askQuestion)
                }
            }
            .navigationBarTitle("MultiTraining")
        }
        .alert(isPresented: $isGameOver){
            Alert(title: Text("Your score is: \(score)"), message: Text("Want to try again"), dismissButton: .default(Text("Try again")) {
                self.isGameStarted = false
                })
        }
        
    }
    
    func startGame(first: Int, second: Int, third: Int) {
        tablesArray.removeAll()
        questionsArray.removeAll()
        
        let table1 = String(first)
        tablesArray.append(table1)
        if second != 0 {
            let table2 = String(second)
            tablesArray.append(table2)
        }
        if third != 0 {
            let table3 = String(third)
            tablesArray.append(table3)
        }
        getQuestions()
        isGameStarted = true
    }
    
    func getQuestions() {
        for table in tablesArray {
            for i in 1 ... 10 {
                questionsArray.append("\(table)x\(i)")
            }
        }
    }
    
    func askQuestion() {
        currentQuestion = Int.random(in: 1 ..< questionsArray.count)
    }
    
    func evaluate() {
        let answer1 = Int(answer)
        if answer1 == (number1 * number2) {
            score += 1
        } else {
            score -= 1
        }
        questions += 1
        
        if questions < questionsSelected {
            askQuestion()
        } else {
            isGameOver = true
        }
        answer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
