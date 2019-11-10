//
//  ViewController.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var booksTableView: UITableView!
    var bookList: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
    }
    
    func loadBooks() {
        APIManager.shared.books(byAuthor: "Tolkien") { (items, error) in
            guard let items = items else { return }
            items.forEach { (item) in
                print(item.volumeInfo.title)
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.bookList[indexPath.row].volumeInfo.title
        return cell
    }
    
    
}
