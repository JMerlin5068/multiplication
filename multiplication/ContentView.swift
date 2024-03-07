//
//  ContentView.swift
//  multiplication
//
//  Created by Student on 3/4/24.
//

import SwiftUI

struct ContentView: View {

    @State private var num1 = Int()
    @State private var num2 = Int()
    @State private var correctAnswer = Int()
    @State private var randomAnswers = [Int]()
    @State private var difficulty = 2
    @State private var score = Int()

    @State private var questionNumber = Int()
    @State private var selectedNumberOfQuestions = 5
    let numberOfQuestions = [5, 10, 20]

    @State private var isVisible = false
    @State private var endGame = false

    var body: some View {
         VStack {
               VStack {
                Stepper("Select Difficulty:  \(difficulty)", value: $difficulty, in: 2...12)
                    .padding()
                    .shadow(radius: 10)

                HStack {
                    Text("Number of Questions: ")
                    Picker("Number of Question", selection: $selectedNumberOfQuestions) {
                        ForEach(numberOfQuestions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()

                Divider()
                }

                Text("Question number: \(questionNumber)")
                Spacer()

                Text("What is \(num1) x \(num2) = ? ")
                    .padding()

                HStack {
                    ForEach(randomAnswers, id:\.self) { num in
                        Button {
                            withAnimation{
                            numberTapped(num)
                            }

                        } label: {
                            Text("\(num)")
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .font(.title2.bold())
                                .background(.indigo)
                                .clipShape(Circle())
                        }
                        .padding(.vertical, 8.0)
                        .alert("It's GameOVER", isPresented: $endGame) {
                            Button("Ok", action: newGame)
                        } message: {
                            Text("Your score is \(score)")
                        }

                    }
                }
             
                Spacer()
                if !isVisible {
                    Button {
                        answer()
                        isVisible.toggle()
                    } label: {
                        Text("Start Game")
                            .foregroundColor(.indigo)

                    }
                    .padding()
                }

                Text("Your score is \(score)")
            }
    }

    func answer() {
        for _ in 1...4 {
        num1 = Int.random(in: 1...difficulty)
        num2 = Int.random(in: 1...difficulty)

        correctAnswer = num1 * num2
        randomAnswers.append(correctAnswer)
        }
        createRandomAnswers()

    }

    func createRandomAnswers() {
        randomAnswers.shuffle()
    }

    func numberTapped(_ num: Int){
        if num == correctAnswer {
            score += 1
            questionNumber += 1
            randomAnswers.removeAll()
            answer()
        } else {
            randomAnswers.removeAll()
            questionNumber += 1
            answer()
        }
        if selectedNumberOfQuestions == questionNumber {
            endGame = true
        }
    }

    func newGame() {
        score = 0
        questionNumber = 0
        randomAnswers.removeAll()
        isVisible.toggle()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
