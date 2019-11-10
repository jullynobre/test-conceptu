//
//  BookCodableStructs.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import Foundation

// MARK: - BookSearch
struct BookSearch: Codable {
    let kind: String
    let totalItems: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind: String?
    let id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let accessInfo: AccessInfo
}

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let country, viewability: String
    let embeddable, publicDomain: Bool
}

// MARK: - Epub
struct Epub: Codable {
    let isAvailable: Bool
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let publishedDate: String?
    let publisher: String?
    let subtitle: String?
    let authors: [String]?
    let description: String?
    let categories: [String]?
    let industryIdentifiers: [IndustryIdentifier]?
    let readingModes: ReadingModes
    let printType, maturityRating: String
    let allowAnonLogging: Bool
    let contentVersion: String
    let imageLinks: ImageLinks?
    let language: String
    let previewLink: String
    let infoLink, canonicalVolumeLink: String
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
    let medium, large, extraLarge: String?
}

// MARK: - IndustryIdentifier
struct IndustryIdentifier: Codable {
    let type, identifier: String
}

// MARK: - ReadingModes
struct ReadingModes: Codable {
    let text, image: Bool
}
