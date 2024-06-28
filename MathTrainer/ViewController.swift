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
    
    // MARK: - Properties
    var selectedType: MathType = .add
    let uiBuilder = UIBuilder()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        uiBuilder.configureButton(buttonsCollection)
    }

    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }

    // MARK: - IBActions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathType(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }

    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }
}

