//
//  BookDetailsViewController.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    private var bookDetailsView: BookDetailsView?
    private var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        loadViewData()
    }
    
    private func setUpView() {
        self.bookDetailsView = BookDetailsView()
        self.view = self.bookDetailsView
    }
    
    private func loadViewData() {
        self.bookDetailsView?.bookTitle.text = self.item?.volumeInfo.title
        self.bookDetailsView?.bookDescription.text = self.item?.volumeInfo.description ?? "This book has no description."
    }
    
    func setItem(item: Item) {
        self.item = item
    }
}
