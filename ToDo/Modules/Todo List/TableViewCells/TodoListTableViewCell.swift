//
//  TodoListTableViewCell.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 20/12/2021.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    // MARK: properties
    var todoItem: ToDoItem? {
        didSet {
            setupData()
        }
    }
    
    var checkButtonTapped: (()->())?
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // MARK: cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: IBActions
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        checkButtonTapped?()
    }
    
    // MARK: setupData
    private func setupData() {
        titleLabel.text = todoItem?.title
        checkButton.isSelected = todoItem?.checked ?? false
    }

}
