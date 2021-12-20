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
    
    private var search = UISearchController(searchResultsController: nil)

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        checkForSearchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        navigationItem.title = "TODO LIST"
        
        let addBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBarButtonTapped))
        navigationItem.rightBarButtonItem = addBarButton
        
        search.searchBar.delegate = self
        search.searchBar.sizeToFit()
        search.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        search.searchBar.placeholder = "Search here"
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    // MARK: - showTextFieldAlert
    private func showTextFieldAlert(with todoItem: ToDoItem? = nil) {
        var title = "Add Item"
        var message = "Add Your ToDo Item"
        var textfieldText = ""
        var okTitle = "Save"
        if let todoItem = todoItem {
            title = "Edit Item"
            message = "Edit Your ToDo Item"
            textfieldText = todoItem.title ?? ""
            okTitle = "Edit"
        }
        alertWithTextField(title: title, message: message, textfieldText: textfieldText, okTitle: okTitle) { [weak self] typedText in
            guard let self = self else { return }
            if let todoItem = todoItem {
                todoItem.title = typedText
                self.updateItem(oldItem: todoItem)
                return
            }
            let newTodoItem = TodoItemModel(id: UUID().uuidString, title: typedText, checked: false)
            self.todoPersistentService.save(item: newTodoItem)
            self.checkForSearchItems()
        }
    }
    
    // MARK: - updateItem
    private func updateItem(oldItem: ToDoItem) {
        let newItem = TodoItemModel(id: oldItem.id, title: oldItem.title, checked: oldItem.checked)
        todoPersistentService.update(oldItem: oldItem, newItem: newItem)
        checkForSearchItems()
    }
    
    private func checkForSearchItems() {
        let searchedText = search.searchBar.text!.lowercased()
        if !searchedText.isEmpty {
            todoItems = todoItems.filter({ ($0.title?.contains(searchedText) ?? false) || ($0.id?.contains(searchedText) ?? false ) })
        } else {
            fetchData()
        }
    }
    
    // MARK: - objc functions
    // MARK: - addBarButtonTapped
    @objc private func addBarButtonTapped() {
        showTextFieldAlert()
    }
    
}

// MARK: - UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoItems.element(at: indexPath.item)
        let cell: TodoListTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.todoItem = todoItem
        cell.checkButtonTapped = { [weak self] in
            guard let self = self,
                  let todoItem = todoItem else { return }
            todoItem.checked = !todoItem.checked
            self.updateItem(oldItem: todoItem)
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todoItem = todoItems.element(at: indexPath.item)
        showTextFieldAlert(with: todoItem)
    }
    
    // MARK: trailingSwipeActionsConfigurationForRowAt
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todoItem = todoItems.element(at: indexPath.item)
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self,
                  let todoItem = todoItem else { return }
            self.todoPersistentService.delete(item: todoItem)
            self.checkForSearchItems()
            completionHandler(true)
        }
        delete.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
}

// MARK: UISearchBarDelegate
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        checkForSearchItems()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        checkForSearchItems()
    }
    
}
