//
//  UITableView+Extension.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 20/12/2021.
//

import UIKit

extension UITableView {
    
    func dequeueCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)") as! T
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
    
}
