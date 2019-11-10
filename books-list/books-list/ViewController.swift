//
//  ViewController.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.books(byAuthor: "Tolkien") { (items, error) in
            guard let items = items else { return }
            items.forEach { (item) in
                print(item.volumeInfo.title)
            }
        }
    }


}

