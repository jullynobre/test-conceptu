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
    }
    
    func setUpView() {
        self.booksView = BooksView()
        booksView?.booksTableView.delegate = self
        booksView?.booksTableView.dataSource = self
        self.view = self.booksView
    }
    
    func loadBooks() {
        APIManager.shared.books(byAuthor: "Tolkien") { (items, error) in
            guard let items = items else { return }
            items.forEach { (item) in
                self.bookList.append(item)
                let newRowIndexPath = IndexPath.init(row: self.bookList.count - 1, section: 0)
                self.booksView?.booksTableView.insertRows(at: [newRowIndexPath], with: .automatic)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
//        let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main)
//            .instantiateViewController(withIdentifier: "BookDetails") as! BookDetailsViewController
        self.navigationController?.pushViewController(BookDetailsViewController(), animated: true)
    }
}
