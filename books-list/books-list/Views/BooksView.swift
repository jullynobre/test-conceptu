//
//  BooksView.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class BooksView: UIView {
    lazy var booksTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BooksView: ViewCode {
    func buildViewHierarchy() {
        addSubview(booksTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            booksTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            booksTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            booksTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            booksTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
    
    
}
