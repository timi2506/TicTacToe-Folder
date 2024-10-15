//
//  ContentView.swift
//  NotSusPicious
//
//  Created by Tim Schuchardt on 15.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var gameStatus = "Tic-Tac-Toe: Player X's turn"
    @State private var enterKeyCount = 0

    var body: some View {
        VStack {
            Text(gameStatus)
                .font(.title2)
                .padding()

            // Move the button below the game status
            Button(action: resetGame) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 44, height: 44) // Set the size of the button
                    .background(Color.blue)
                    .cornerRadius(8) // Rounded corners, can be adjusted
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling
            .padding(.bottom, 10) // Add some space below the button

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<9) { index in
                    Button(action: { handleMove(at: index) }) {
                        Text(board[index])
                            .font(.system(size: 50))
                            .frame(width: 80, height: 80)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification)) { _ in
            if let event = NSApp.currentEvent, event.type == .keyDown, event.keyCode == 36 { // Enter key code
                enterKeyCount += 1
                if enterKeyCount == 3 {
                    openResourcesFolder()
                    enterKeyCount = 0
                }
            }
        }
    }

    private func handleMove(at index: Int) {
        guard board[index].isEmpty else { return }

        board[index] = currentPlayer
        if checkWin(for: currentPlayer) {
            gameStatus = "Player \(currentPlayer) wins!"
        } else if board.allSatisfy({ !$0.isEmpty }) {
            gameStatus = "It's a draw!"
        } else {
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
            gameStatus = "Tic-Tac-Toe: Player \(currentPlayer)'s turn"
        }
    }

    private func checkWin(for player: String) -> Bool {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6]             // Diagonals
        ]
        return winningCombinations.contains { combination in
            combination.allSatisfy { board[$0] == player }
        }
    }

    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        gameStatus = "Tic-Tac-Toe: Player X's turn"
    }

    private func openResourcesFolder() {
        if let resourcesPath = Bundle.main.resourcePath {
            NSWorkspace.shared.open(URL(fileURLWithPath: resourcesPath))
        }
    }
}

#Preview {
    ContentView()
}
