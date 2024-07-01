//
//  ViewController.swift
//  MathTrainer
//
//  Created by Анастасия Ахановская on 25.06.2024.
//

import UIKit

enum MathType: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var addCountLabel: UILabel!
    @IBOutlet weak var subtractCountLabel: UILabel!
    @IBOutlet weak var multiplyCountLabel: UILabel!
    @IBOutlet weak var divideCountLabel: UILabel!
    
    // MARK: - Properties
    var selectedType: MathType = .add
    let uiBuilder = UIBuilder()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        uiBuilder.configureButton(buttonsCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        printing()
    }

    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    func printing() {
            addCountLabel.text = count.printingAdd()
            subtractCountLabel.text = count.printingSubtract()
            multiplyCountLabel.text = count.printingMultiply()
            divideCountLabel.text = count.printingDivide()
        }

    // MARK: - IBActions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathType(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }

    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }
}

