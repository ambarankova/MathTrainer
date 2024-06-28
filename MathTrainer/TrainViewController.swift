//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Анастасия Ахановская on 25.06.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    // MARK: - Properties
    let uiBuilder = UIBuilder()

    var type: MathType = .add {
        didSet {
            switch type {
            case .add: sign = "+"
            case .subtract: sign = "-"
            case .multiply: sign = "*"
            case .divide: sign = "/"
            }
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign = ""
    private var count = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configureButtons()
        uiBuilder.configureButton([leftButton, rightButton])
    }
    
    // MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    // MARK: - Methods
    private func configureQuestion() {
        switch type {
        case .add, .subtract:
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
        case .multiply:
            firstNumber = Int.random(in: 1...9)
            secondNumber = Int.random(in: 1...9)
        case .divide:
            secondNumber = Int.random(in: 1...9)
            firstNumber = secondNumber * Int.random(in: 1...9)
        }
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func configureButtons() {
        
        [leftButton, rightButton].forEach { button in
            button?.backgroundColor = .systemYellow
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            let isSecondAttempt = (rightButton.backgroundColor == .red) || (leftButton.backgroundColor == .red)
            
            if isSecondAttempt == false {
                count += 1
            }
            
            // count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
        
        countLabel.text = "Очков: \(count)"
        
    }
}

