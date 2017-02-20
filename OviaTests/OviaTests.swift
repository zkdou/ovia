//
//  OviaTests.swift
//  OviaTests
//
//  Created by Zongkun Dou on 2/18/17.
//  Copyright © 2017 Zongkun Dou. All rights reserved.
//

import XCTest
@testable import Ovia

class OviaTests: XCTestCase {

    var viewModel: ViewModelProtocol!
    let mock = Mock()

    override func setUp() {
        super.setUp()

        self.viewModel = ViewModel()
        self.viewModel.delegate = mock
    }
    
    override func tearDown() {
        self.viewModel = nil

        super.tearDown()
    }
    
    func testFunctionsWithEmptyString() {
        viewModel.inputText = ""

        XCTAssertEqual(mock.q1Result, "")
        XCTAssertEqual(mock.q2Result, "")
    }

    func testFunctionsWithOnlyWhiteSpaces() {
        viewModel.inputText = "  "

        XCTAssertEqual(mock.q1Result, "Number of vowel 0 \nNumber of Consonant 0 \nNumber of number 0 \nNumber of punctuation 0")
        XCTAssertEqual(mock.q2Result, "  ")
    }

    func testFunctionsWithLeadingSpaces() {
        viewModel.inputText = "  hello"

        XCTAssertEqual(mock.q1Result, "Number of vowel 2 \nNumber of Consonant 3 \nNumber of number 0 \nNumber of punctuation 0")
        XCTAssertEqual(mock.q2Result, "  h3o")
    }

    func testFunctionsWithTrailingSpaces() {
        viewModel.inputText = "hello "

        XCTAssertEqual(mock.q1Result, "Number of vowel 2 \nNumber of Consonant 3 \nNumber of number 0 \nNumber of punctuation 0")
        XCTAssertEqual(mock.q2Result, "h3o ")
    }

    func testFunctionsWithOneWord() {
        viewModel.inputText = "hi."

        XCTAssertEqual(mock.q1Result, "Number of vowel 1 \nNumber of Consonant 1 \nNumber of number 0 \nNumber of punctuation 1")
        XCTAssertEqual(mock.q2Result, "hi.")
    }

    func testFunctionsWithWords() {
        viewModel.inputText = "hello world"

        XCTAssertEqual(mock.q1Result, "Number of vowel 3 \nNumber of Consonant 7 \nNumber of number 0 \nNumber of punctuation 0")
        XCTAssertEqual(mock.q2Result, "h3o w3d")
    }

    func testFunctionsWithNumber() {
        viewModel.inputText = "Password P@ssw0rd"

        XCTAssertEqual(mock.q1Result, "Number of vowel 2 \nNumber of Consonant 12 \nNumber of number 1 \nNumber of punctuation 1")
        XCTAssertEqual(mock.q2Result, "P6d P6d")
    }

    func testFunctionsWithTerminationMark() {
        viewModel.inputText = "don't know P@ssw0rd. don't know!"

        XCTAssertEqual(mock.q1Result, "Number of vowel 4 \nNumber of Consonant 18 \nNumber of number 1 \nNumber of punctuation 5")
        XCTAssertEqual(mock.q2Result, "d3t k2w P6d. d3t k3!")
    }
}
