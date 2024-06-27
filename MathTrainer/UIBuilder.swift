//
//  UIBuilder.swift
//  MathTrainer
//
//  Created by Alex on 27.06.2024.
//

import UIKit

class UIBuilder {
    
    func configureButton(_ buttons: [UIButton]) {
        buttons.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 2
        }
    }
}
