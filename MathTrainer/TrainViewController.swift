//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Анастасия Ахановская on 25.06.2024.
//

import UIKit

/// Не создавай экземпрляры в не класса / структуры. Это создает объект в глобальной области видимости
/// Для того что бы передать данные с одного экрана на другой есть несколько подходов:
/// Реактивное программирование (нативный от эпл - Combine), делегаты (Delegate)  и кложуры (Closures)
/// Почитай про делегаты и кложуры, тема немного сложная но !обязательно! нужна. На работе будет использоваться очень часто
/// Ссылка на мою статью о делегатах: https://habr.com/ru/articles/703232/, о кложурах не писал, но примеров в интернете оч много, погугли
/// Почему сейчас не работает передача данных? Объект не хранится нигде в памяти в момент закрытия контроллера
/// Ниже напишу пример с делегатом
var count = Count()

/// AnyObject нужен что бы объявить свойство делегата в классе
protocol TrainViewControllerDelegate: AnyObject {
    func send(count: Int)
}

final class TrainViewController: UIViewController {
    
    /// Объявим свойство, обязательно! weak что бы не создать цикл сильных ссылок
    weak var delegate: TrainViewControllerDelegate?
    
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
        printScore()
    }
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
        printScore()
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
                switch type {
                case .add:
                    count.countAdd += 1
                case .subtract:
                    count.countSubtract += 1
                case .multiply:
                    count.countMultiply += 1
                case .divide:
                    count.countDivide += 1
                }
            }
            
            // Почему подсчет неверный?
            // count += isSecondAttempt ? 0 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
    
    private func printScore() {
        switch type {
            case .add:
            countLabel.text = count.printingAdd()
            delegate?.send(count: count.countAdd)
            case .subtract:
            countLabel.text = count.printingSubtract()
            delegate?.send(count: count.countSubtract)
            case .multiply:
            countLabel.text = count.printingMultiply()
            delegate?.send(count: count.countMultiply)
            case .divide:
            countLabel.text = count.printingDivide()
            delegate?.send(count: count.countDivide)
            }
    }
}

