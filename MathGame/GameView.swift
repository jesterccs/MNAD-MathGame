//
//  ContentView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-13.
//

import SwiftUI

/// Add `enum` cases with `rawValues`  below.
/// Conform `Operator` to `CaseIterable`

enum Operator: String, CaseIterable {
    case addition = "+"
    case substraction = "-"
    case division = "/"
    case multiplication = "*"
}

struct GameView: View {
    
    @Binding var fontSize: Double
    @Binding var selectedColor: Color
    
    // Declare your Variables here
    @AppStorage("question") var mathQuestion: String = ""
    @State var answer: Int = 0
    @State var userInput: String = ""
    @AppStorage("points") var points: Int = 0
    @State var statement: String = ""
    @State var isCorrect: Bool = false
    @State var showStatement: Bool = false
    @State var submitted: Bool = false

    
    var body: some View {
        // GameView content
        VStack {
            Text("Guess the answer!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(selectedColor)
            
            Text("What is \(mathQuestion)")
                .font(.largeTitle)
                .bold()
            
            HStack {
                TextField("", text: $userInput, prompt: Text("Answer"))
                Button("Submit") {
                    checkAnswer()
                    showStatement = true
                    submitted = true
                }
                .buttonStyle(.bordered)
                .tint(Color("Sapphire"))
                .disabled(submitted)
            }
            .padding()
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            Spacer()
            
            if showStatement == true {
                if isCorrect == true {
                    Label(statement, systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else {
                    Label(statement, systemImage: "multiply.circle.fill")
                        .foregroundColor(.red)
                }
            }
            
            
            Text(String(points))
                .font(.system(size: 100))
                .fontWeight(.bold)
            Spacer()
            
            VStack {
                Text("Instructions")
                    .padding()
                Text("Submit the correct answer and gain 1 point. Submit a wrong answer or press on \"NEXT\" and you will lose 1 point")
                    .multilineTextAlignment(.center)
            }
            .font(.system(size: CGFloat(fontSize)))
            
            Button("NEXT") {
                generateQuestion()
                userInput = ""
                showStatement = false
                submitted = false
            }.buttonStyle(.bordered)
                .tint(Color("Emerald"))
            Spacer()
        }.padding()
            .onAppear {
                generateQuestion()
            }
    }
    
    private func generateOperands() -> Int {
        let range = 1..<10 // Generates a range between 1 to 99 
        let randomNumber: Int? = range.randomElement()
        return randomNumber ?? 0
    }
    
    private func generateOperator() -> Operator {
        let operatorArr: [Operator] = Operator.allCases // Getting an array of PersonType
        let operatorType: Operator? = operatorArr.randomElement() // Getting a random element print(randomPersonType.rawValue)
        return operatorType ?? .addition
    }
    
    private func generateQuestion() {
        // Generate random question with 2 random operands and 1 operator using the above functions and show it to the user
        let number1 = generateOperands()
        let number2 = generateOperands()
        let randomOperator = generateOperator()
        
        switch randomOperator {
        case .addition:
            mathQuestion = "\(number1) + \(number2)"
            answer = number1 + number2
        case .substraction:
            mathQuestion = "\(number1) - \(number2)"
            answer = number1 - number2
        case .multiplication:
            mathQuestion = "\(number1) * \(number2)"
            answer = number1 * number2
        default:
            if number2 == 0 {
                generateQuestion()
            } else {
                mathQuestion = "\(number1) / \(number2)"
                answer = number1 / number2
            }
        }
    }
    
    private func checkAnswer() {
        // Check answer here
        if Int(userInput) == answer {
            statement = "CORRECT ANSWER! WELL DONE!"
            addPoint()
            isCorrect = true
        } else {
            statement = "Incorrect answer! The actual answer is \(answer)"
            deductPoint()
            isCorrect = false
        }
        
    }
    
    private func addPoint() {
        // Increment points here
        points += 1
    }
    
    private func deductPoint() {
        // Decrease points here
        if points != 0 {
            points -= 1
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(fontSize: .constant(14.0), selectedColor: .constant(Color("Sapphire")))
    }
}
