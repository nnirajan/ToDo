//
//  UIViewController+Extension.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 20/12/2021.
//

import UIKit

extension UIViewController {
    
    func alertWithTextField(title: String, message: String, textfieldText: String = "", okTitle: String, cancelTitle: String = "Cancel", okCompletion: @escaping (String)->(), cancelAction: (()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField()
        guard let textField = alert.textFields?.first else { return }
        textField.text = textfieldText
        let action = UIAlertAction(title: okTitle, style: .default, handler: { [weak textField] (_) in
            guard let value = textField?.text else {
                return
            }
            okCompletion(value)
        })
        alert.addAction(action)
        alert.addAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIAlertController {
    
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: (()->())? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: { _ in
            handler?()
        })
        self.addAction(action)
    }
    
}
