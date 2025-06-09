//
//  SearchResponse.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let resultCount: Int?
    let results: [SearchResult]?
}

// MARK: - SearchResult
struct SearchResult: Codable {
    let features: [String]?
    let isGameCenterEnabled: Bool?
    let supportedDevices, advisories: [String]?
    let screenshotUrls, ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String]?
    let artworkUrl60, artworkUrl512, artworkUrl100: String?
    let artistViewURL: String?
    let kind: String?
    let currency: String?
    let trackID: Int?
    let trackName, releaseNotes, description: String?
    let genreIDS: [String]?
    let releaseDate: String?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let sellerName: String?
    let currentVersionReleaseDate: String?
    let bundleID, minimumOSVersion: String?
    let averageUserRatingForCurrentVersion, averageUserRating: Double?
    let trackCensoredName: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let sellerURL: String?
    let formattedPrice: String?
    let contentAdvisoryRating: String?
    let userRatingCountForCurrentVersion: Int?
    let trackViewURL: String?
    let trackContentRating: String?
    let primaryGenreName: String?
    let primaryGenreID, price, artistID: Int?
    let artistName: String?
    let genres: [String]?
    let version: String?
    let wrapperType: String?
    let userRatingCount: Int?

    enum CodingKeys: String, CodingKey {
        case features, isGameCenterEnabled, supportedDevices, advisories, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL
        case kind, currency
        case trackID
        case trackName, releaseNotes, description
        case genreIDS
        case releaseDate, isVppDeviceBasedLicensingEnabled, sellerName, currentVersionReleaseDate
        case bundleID
        case minimumOSVersion
        case averageUserRatingForCurrentVersion, averageUserRating, trackCensoredName, languageCodesISO2A, fileSizeBytes
        case sellerURL
        case formattedPrice, contentAdvisoryRating, userRatingCountForCurrentVersion
        case trackViewURL
        case trackContentRating, primaryGenreName
        case primaryGenreID
        case price
        case artistID
        case artistName, genres, version, wrapperType, userRatingCount
    }
}
