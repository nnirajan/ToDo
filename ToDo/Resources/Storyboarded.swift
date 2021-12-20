//
//  Storyboarded.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 19/12/2021.
//

import UIKit

protocol Storyboarded {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(storyboardIdentifier)")
        }
        return viewController
    }
    
}
