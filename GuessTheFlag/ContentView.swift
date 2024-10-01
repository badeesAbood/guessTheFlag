//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by MASARAT on 1/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var contries: [String] = ["Estonia" , "France" , "US" , "Germany" , "Ireland", "Italy" , "Nigeria" , "Poland" ,"Spain" , "UK", "Ukraine"].shuffled()
    @State private var  correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var scorePresented = false
    @State private var questionsAlertPresented = false
    @State private var score = 0
    @State private var  questions = 1
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag").font(.system(size: 30 , design: .rounded )).foregroundStyle(.white)
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of ").foregroundStyle(.secondary).font(.title2)
                        Text(contries[correctAnswer]).foregroundStyle(.secondary).font(.title).fontWeight(.bold)
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            onSubmitAnswer(number)
                        } label: {
                            Image(contries[number]).clipShape(.capsule).shadow(color: .indigo, radius: 10)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical ,20 )
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                
                Spacer()
                Spacer()
                Text("Your Score is \(score)").foregroundStyle(.white).font(.title2)
                
            }.padding()
        }.alert(scoreTitle , isPresented: $scorePresented) {
            Button("Continue" , action: shuffle)
        } message: {
            Text("Your answer is \(scoreTitle)")
        } .alert("The End ",isPresented: $questionsAlertPresented){
            Button("restart Game" , action: restartGame)
        }message: {
            Text("Your final score is \n \(score)")
            Text("Do you want to restart the game")
        }
    }
    
    func shuffle() {
        if questions < 8 {
            contries.shuffle()
                 correctAnswer = Int.random(in: 0..<2)
                 questions += 1
        } else {
            questionsAlertPresented = true
        }
    }
    
    func onSubmitAnswer(_ number: Int){
        scorePresented = true
        if  correctAnswer == number {
            scoreTitle = "Correct !"
            score += 1
        } else {
            scoreTitle = "Wrong ! thats the flag of \(contries[number])"
            score = 0
        }
    }
    
    func restartGame() {
        questions = 1
        score = 0
    }
}

#Preview {
    ContentView()
}
   
