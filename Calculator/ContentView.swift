//import SwiftUI//  ContentView.swift//
//  Calculator
//
//  Created by Tugay Kir on 19.03.25.
//

import SwiftUI

// Enumeration for calculator buttons
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

    // Define button colors based on the button type
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(
                UIColor(
                    red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0,
                    alpha: 1))
        }
    }
}

// Enumeration for mathematical operations
enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {

    // State variables to manage the calculator's state
    @State var value = "0"  // Current displayed value
    @State var runningNumber = 0  // Stores the running number for operations
    @State var currentOperation: Operation = .none  // Current selected operation

    // Layout of calculator buttons
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            // Set the background color to black
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                // Display for the current value
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()

                // Buttons layout
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(
                                action: {
                                    self.didTap(button: item)  // Handle button tap
                                },
                                label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: self.buttonWidth(item: item),  // Set button width
                                            height: self.buttonHeight()  // Set button height
                                        )
                                        .background(item.buttonColor)  // Set button color
                                        .foregroundColor(.white)  // Set text color
                                        .cornerRadius(
                                            self.buttonWidth(item: item) / 2)  // Round corners
                                })
                        }
                        .padding(.bottom, 3)
                    }
                }
            }
        }
    }

    // Function to handle button taps
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(currentValue + runningValue)"  // Perform addition
                case .subtract: self.value = "\(runningValue - currentValue)"  // Perform subtraction
                case .multiply: self.value = "\(runningValue * currentValue)"  // Perform multiplication
                case .divide: self.value = "\(runningValue / currentValue)"  // Perform division
                case .none:
                    break
                }
            }

            if button != .equal {
                self.value = "0"  // Reset the display for the next number
            }
        case .clear:
            self.value = "0"  // Clear the display
            self.runningNumber = 0  // Reset the running number
            self.currentOperation = .none  // Reset the current operation

        case .decimal:
            if !self.value.contains(".") {
                self.value += "."  // Add a decimal point if not already present
            }
            //, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number  // Replace "0" with the new number
            } else {
                self.value = "\(self.value)\(number)"  // Append the new number
            }
        }
    }

    // Function to calculate button width
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - (4 * 12)) / 4 * 2 + 6  // Wider width for the "0" button
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4  // Standard width for other buttons
    }

    // Function to calculate button height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4  // Standard height for all buttons
    }
}

#Preview {
    ContentView()
}
