//
//  TodoListViewController.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 19/12/2021.
//

import UIKit

class TodoListViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    static var storyboardName: String { return "TodoList" }
    
    private let todoPersistentService = TodoPersistentService.shared
    
    private var todoItems = [ToDoItem]() {
        didSet {
            reloadTableView()
        }
    }

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "TODO LIST"
        fetchData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - IBActions
    
    // MARK: - Other Functions
    private func setup() {
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - fetchData
    private func fetchData() {
        todoItems = todoPersistentService.fetch()
    }
    
    // MARK: setupNavigationBar
    private func setupNavigationBar() {
        let addBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBarButtonTapped))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    // MARK: - setupTableView
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - reloadTableView
    private func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: - objc functions
    // MARK: - addBarButtonTapped
    @objc private func addBarButtonTapped() {
        let title = "Add Item"
        let message = "Add Your ToDo Item"
        let okTitle = "Save"
        alertWithTextField(title: title, message: message, okTitle: okTitle) { [weak self] text in
            guard let self = self else { return }
            let item = TodoItemModel(id: UUID().uuidString, title: text, checked: false)
            self.todoPersistentService.save(item: item)
            self.fetchData()
        }
    }
    
}

// MARK: - UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("uoip")
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoItems.element(at: indexPath.item)
        let cell: TodoListTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.todoItem = todoItem
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    
}
