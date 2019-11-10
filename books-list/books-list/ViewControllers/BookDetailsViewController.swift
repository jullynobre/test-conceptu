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
    
    private var indexInStaerdBooks: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        loadViewData()
        configureBarButton()
    }
    
    private func setUpView() {
        self.bookDetailsView = BookDetailsView()
        self.view = self.bookDetailsView
    }
    
    private func loadViewData() {
        self.bookDetailsView?.bookTitle.text = self.item?.volumeInfo.title
        self.bookDetailsView?.bookDescription.text = self.item?.volumeInfo.description ?? "This book has no description."
        
        //Load Image
        let imageURL = self.item?.volumeInfo.imageLinks?.large ?? self.item?.volumeInfo.imageLinks?.medium ?? self.item?.volumeInfo.imageLinks?.thumbnail ?? ""
        Request<BooksAPI>().loadImage(from: imageURL) { (image, error) in
            if image != nil {
                DispatchQueue.main.async {
                    self.bookDetailsView?.bookImage.image = image
                }
            }
        }
    }
    
    private func configureBarButton() {
        let starredBooks = UserDefaults.standard.stringArray(forKey: "StaredBooks")
        if starredBooks != nil {
            self.indexInStaerdBooks = starredBooks!.firstIndex(of: item!.id)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: self.indexInStaerdBooks != nil ? "Unstar" : "Star",
            style: .plain, target: self,
            action: #selector(starButtonTapped)
        )
        
    }
    
    func setItem(item: Item) {
        self.item = item
    }
    
    @objc func starButtonTapped() {
        var starredBooks = UserDefaults.standard.stringArray(forKey: "StaredBooks")
        if starredBooks == nil {
            starredBooks = []
        }
        //Stars the book and save to User Defaults
        if self.indexInStaerdBooks == nil {
            starredBooks?.append(self.item!.id)
            self.indexInStaerdBooks = starredBooks!.count - 1
            UserDefaults.standard.set(starredBooks, forKey: "StaredBooks")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Unstar", style: .plain, target: self, action: #selector(starButtonTapped))
        }
        //Unstars the book and save to User Defaults
        else {
            starredBooks?.remove(at: self.indexInStaerdBooks!)
            self.indexInStaerdBooks = nil
            UserDefaults.standard.set(starredBooks, forKey: "StaredBooks")
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Star", style: .plain, target: self, action: #selector(starButtonTapped))
        }
    }
}
