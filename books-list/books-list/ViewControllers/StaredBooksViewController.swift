//
//  StaredBooksViewController.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class StaredBooksViewController: UIViewController {
    
    var bookList: [Item] = []
    private var booksView: BooksView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stared Books"
       
        self.setUpView()
        //self.loadBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !self.bookList.isEmpty {
            self.bookList = []
            self.booksView?.booksTableView.reloadData()
        }
        self.loadBooks()
    }
    
    private func setUpView() {
        self.booksView = BooksView()
        booksView?.booksTableView.delegate = self
        booksView?.booksTableView.dataSource = self
        self.view = self.booksView
    }
    
    private func loadBooks() {
        self.booksView?.activityIndicator.startAnimating()
        let starredBooks = UserDefaults.standard.stringArray(forKey: "StaredBooks")
        starredBooks?.forEach({ (bookId) in
            APIManager.shared.book(byId: bookId) { (item, error) in
                if item != nil {
                    self.bookList.append(item!)
                    let newRowIndexPath = IndexPath.init(row: self.bookList.count - 1, section: 0)
                    self.booksView?.booksTableView.insertRows(at: [newRowIndexPath], with: .automatic)
                    
                    if self.bookList.count == starredBooks?.count {
                        self.booksView?.activityIndicator.stopAnimating()
                    }
                }
            }
        })
    }
}

extension StaredBooksViewController: UITableViewDelegate, UITableViewDataSource {
    
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
