//
//  ViewUtilities.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 13/3/22.
//

import UIKit

class ViewUtilities {
    static func styleTextField(_ textfield:UITextField) {
        // Create the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        //        bottomLine.backgroundColor = AppConfigs.View.primaryColor.cgColor
        bottomLine.backgroundColor = Theme.current.secondary.cgColor
        
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button: UIButton) {
//        button.backgroundColor = AppConfigs.View.primaryColor
        button.backgroundColor = Theme.current.primary
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
//        button.tintColor = Theme.current.tint
    }
    
    static func styleHollowButton(_ button: UIButton) {
        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderColor = Theme.current.secondary.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
//        button.tintColor = Theme.current.tint
    }
    
    static func styleCard(_ cell: UICollectionViewCell) {
        //        cell.contentView.layer.backgroundColor = AppConfigs.View.blue.cgColor
//        cell.contentView.layer.backgroundColor = Theme.current.primary.cgColor
        cell.contentView.layer.backgroundColor = Theme.current.secondary.cgColor
        // Make corners rounded
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.masksToBounds = true
        
        // Drop shadow
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 0.2
        //        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowColor = Theme.current.secondary.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.masksToBounds = false
    }
    
    static func styleCard(_ view: UIView) {
//        view.layer.backgroundColor = AppConfigs.View.blue.cgColor
//        view.layer.backgroundColor = Theme.current.primary.cgColor
        view.layer.backgroundColor = Theme.current.secondary.cgColor

        // Make corners rounded
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        
        // Drop shadow
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.2
//        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowColor = Theme.current.secondary.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.masksToBounds = false
    }
}

extension UILabel {
    func show(withText text: String) {
        self.text = text
        self.alpha = 1
    }
    
    func hide() {
        self.alpha = 0
    }
}
