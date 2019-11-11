//
//  ViewController.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    var bookList: [Item] = []
    
    private var booksView: BooksView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books"
        
        setUpView()
        loadBooks()
        configureBarButton()
    }
    
    private func setUpView() {
        self.booksView = BooksView()
        booksView?.booksTableView.delegate = self
        booksView?.booksTableView.dataSource = self
        self.view = self.booksView
    }
    
    private func loadBooks() {
        self.booksView?.activityIndicator.startAnimating()
        APIManager.shared.books(byAuthor: "Tolkien") { (items, error) in
            guard let items = items else { return }
            items.forEach { (item) in
                self.bookList.append(item)
                let newRowIndexPath = IndexPath.init(row: self.bookList.count - 1, section: 0)
                self.booksView?.booksTableView.insertRows(at: [newRowIndexPath], with: .automatic)
            }
            self.booksView?.activityIndicator.stopAnimating()
        }
    }
    
    private func configureBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Stared Books",
            style: .plain, target: self,
            action: #selector(pushStaredBooksViewController)
        )
    }
    
    @objc private func pushStaredBooksViewController() {
        self.navigationController?.pushViewController(StaredBooksViewController(), animated: true)
    }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.bookList[indexPath.row].volumeInfo.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetailsVC = BookDetailsViewController()
        bookDetailsVC.setItem(item: self.bookList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(bookDetailsVC, animated: true)
    }
}
