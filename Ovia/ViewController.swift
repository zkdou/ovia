//
//  ViewController.swift
//  Ovia
//
//  Created by Zongkun Dou on 2/18/17.
//  Copyright © 2017 Zongkun Dou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var Q1Solution: UILabel!
    @IBOutlet weak var Q2Solution: UILabel!
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }

    @IBAction func returnKeyPressed(_ sender: Any) {
        viewModel.inputText = self.inputTextField.text
    }
}

extension ViewController: UITextFieldDelegate {
    
}

extension ViewController: ViewModelDelegate {
    func didFinishCalculateQ1Answer(result: String) {
        self.Q1Solution.text = result
        self.view.layoutIfNeeded()
    }
    
    func didFinishCalculateQ2Answer(result: String) {
        self.Q2Solution.text = result
        self.view.layoutIfNeeded()
    }
}
