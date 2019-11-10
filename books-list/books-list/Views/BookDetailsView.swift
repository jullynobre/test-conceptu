//
//  BookDetailsView.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import UIKit

class BookDetailsView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var bookImage: UIImageView = {
        let bookImage = UIImageView()
        bookImage.backgroundColor = .gray
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        return bookImage
    }()
    
    lazy var bookTitle: UILabel = {
        let bookTitle = UILabel()
        bookTitle.text = "Book Title"
        bookTitle.numberOfLines = 0
        bookTitle.font = .systemFont(ofSize: 22, weight: .semibold)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        return bookTitle
    }()
    
    lazy var bookDescription: UILabel = {
        let bookDescription = UILabel()
        bookDescription.text = "The content elements of your scroll view must have left / top / width / height values. In the case of objects such as labels, they have intrinsic sizes, so you only have to define the left & top"
        bookDescription.numberOfLines = 0
        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        return bookDescription
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BookDetailsView: ViewCode {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(bookImage)
        scrollView.addSubview(bookTitle)
        scrollView.addSubview(bookDescription)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            bookImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bookImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bookImage.heightAnchor.constraint(equalTo: bookImage.widthAnchor, multiplier: 1.5)
        ])
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 16),
            bookTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bookTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            bookDescription.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 8),
            bookDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bookDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            bookDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
