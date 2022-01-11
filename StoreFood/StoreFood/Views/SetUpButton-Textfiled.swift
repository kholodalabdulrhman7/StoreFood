//
//  SetUpButton.swift
//  StoreFood
//
//  Created by Kholod Sultan on 19/05/1443 AH.
//

import Foundation
import UIKit
extension UIButton {
  open func setupButton(with title: String) {
    backgroundColor = .black
    setTitle(title, for: .normal)
    setTitleColor(UIColor(#colorLiteral(red: 0.727360785, green: 0.9017360806, blue: 0.8943203092, alpha: 1)), for: .normal)
    layer.cornerRadius = 20
    clipsToBounds = true
  }
    
  open func setupButton(using image: String) {
    setImage(UIImage(systemName: image)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    backgroundColor = .clear
      layer.borderColor = UIColor( #colorLiteral(red: 0.727360785, green: 0.9017360806, blue: 0.8943203092, alpha: 1)).cgColor
  }
}






extension UITextField {
    
    open func setupTextField(with placeholder: NSAttributedString) {
        backgroundColor = .clear
        autocorrectionType = .no
        layer.cornerRadius = 20
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        attributedPlaceholder = placeholder
        tintColor = .white
        textColor = .white
        
    }
}

