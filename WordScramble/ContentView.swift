//
//  ContentView.swift
//  WordScramble
//
//  Created by Buhecha, Neeta (Trainee Engineer) on 10/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) {word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord() {
        // lowercase and trim new word
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // Check at least one char
        guard answer.count > 0 else {return}
        
        // extra validation to come
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    func startGame() {
        // find the url for starttxt in the bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "/n")
                // pick a random element and assign it - remember it will be optional
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from Bundle")
    }
    
}

#Preview {
    ContentView()
}
