//
//  ViewModel.swift
//  Ovia
//
//  Created by Zongkun Dou on 2/18/17.
//  Copyright © 2017 Zongkun Dou. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {
    weak var delegate: ViewModelDelegate? { get set }
    var inputText: String? { get set }
}

protocol ViewModelDelegate: class {
    func didFinishCalculateQ1Answer(result: String)
    func didFinishCalculateQ2Answer(result: String)
}

class ViewModel: ViewModelProtocol {

    weak internal var delegate: ViewModelDelegate?
    
    var inputText: String? = "" {
        didSet {
            calculateQ1(input: inputText)
            calculateQ2(input: inputText)
        }
    }
    
    private func calculateQ1(input text: String?) {
        guard let str = text?.lowercased(),
            !str.isEmpty else { return }
        
        var numberOfVowel = 0
        var numberOfConsonant = 0
        var numberOfNumber = 0
        var numberOfPunctuation = 0
        
        let vowelSet = CharacterSet(charactersIn: "aeiou")
        let digits = CharacterSet.decimalDigits
        let allAlph = CharacterSet.letters
        let punctuation = CharacterSet.punctuationCharacters
        
        for char in str.unicodeScalars {
            if vowelSet.contains(char) {
                numberOfVowel += 1
            } else if allAlph.contains(char) {
                numberOfConsonant += 1
            } else if digits.contains(char) {
                numberOfNumber += 1
            } else if punctuation.contains(char) {
                numberOfPunctuation += 1
            }
        }
        
        var output = "Number of vowel \(numberOfVowel) \n"
        output += "Number of Consonant \(numberOfConsonant) \n"
        output += "Number of number \(numberOfNumber) \n"
        output += "Number of punctuation \(numberOfPunctuation)"
        
        self.delegate?.didFinishCalculateQ1Answer(result: output)
    }
    
    private func calculateQ2(input text: String?) {
        guard let str = text else { return }

        guard !str.isEmptyOrWhitespace() else {
            self.delegate?.didFinishCalculateQ2Answer(result: str)
            return
        }
        
        var result = ""
        let splitedWords = str.components(separatedBy: CharacterSet.whitespaces)
        
        for i in 0..<splitedWords.count {
            let splitedWord = splitedWords[i]
            let wordCount = splitedWord.characters.count
            
            if splitedWord.characters.last == "." {
                if wordCount <= 3 {
                    result += "\(splitedWord)"
                } else {
                    let last = String(splitedWord.characters.suffix(2))
                    if let first = splitedWord.characters.first {
                        result += "\(first)\(wordCount - 3)\(last)"
                    }
                }
            } else {
                // Handle the case of empty space
                if wordCount <= 2 {
                    result += "\(splitedWord)"
                } else {
                    if let first = splitedWord.characters.first,
                        let last = splitedWord.characters.last {
                        result += "\(first)\(wordCount - 2)\(last)"
                    }
                }
            }
            
            if i < splitedWords.count - 1 {
                result += " "
            }
        }
        
        self.delegate?.didFinishCalculateQ2Answer(result: result)
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {

        if(self.isEmpty) {
            return true
        }

        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
}
