//
//  Array+Extension.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 20/12/2021.
//

import Foundation

extension Array {
    
    func element(at index: Int) -> Element? {
        if index < count && index >= 0 {
            return self[index]
        }
        return nil
    }
    
}
