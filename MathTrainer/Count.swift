//
//  Count.swift
//  MathTrainer
//
//  Created by Анастасия Ахановская on 28.06.2024.
//

import UIKit

class Count {
    
    var countAdd = 0
    var countSubtract = 0
    var countMultiply = 0
    var countDivide = 0
    
    func printingAdd() -> String {
        return "Score: \(countAdd)"
    }
    
    func printingSubtract() -> String {
        return "Score: \(countSubtract)"
    }
    
    func printingMultiply() -> String {
        return "Score: \(countMultiply)"
    }
    
    func printingDivide() -> String {
        return "Score: \(countDivide)"
    }
}
