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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            booksTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            booksTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            booksTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            booksTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
    
    
}
