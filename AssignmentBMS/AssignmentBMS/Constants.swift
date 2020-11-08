//
//  Constants.swift
//  AssignmentBMS
//
//  Created by Ajay on 10/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation
import UIKit

enum Strings {
    static let moviesDBTitle = "Movies"
    static let placeholder = "Search movie name..."
    
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let retry = "Retry"
    static let error = "Error"
    static let close = "close"
    
    static let recentSearch = "Recently Searched Movies"
    
    static let synopsis = "Synopsis"
    static let reviews = "Reviews"
    static let similarMovies = "Similar Movies"
    static let cast = "Cast"
}

enum APP_FONT_SIZE: Float {
    case TITLE      = 20
    case DEFAULT    = 17
    case SUB_TITLE  = 14
    case SMALL      = 12
    case NANO       = 10
    case HEADER1    = 32
    case HEADER2    = 26
    case HEADER3    = 22
}

enum APP_FONT_STYLE: String {
    case LIGHT      = "HelveticaNeue-Light"
    case REGULAR    = "HelveticaNeue"
    case MEDIUM     = "HelveticaNeue-Medium"
    case BOLD       = "HelveticaNeue-Bold"
}

enum APP_IMAGES: String {
    case SEARCH = "Search"
    case DISCLOSURE = "Disclosure"
}

enum APP_COLOR: String {
    case SUB_THEME = "70c295"
    case THEME = "3ca5dd"
}
    
enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let defaultPadding: CGFloat = 8
    static let numberOfColumns: CGFloat = 2
    static let defaultRadius: CGFloat = 10
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 20
}

public enum ViewState: Equatable {
    case none
    case loading
    case error(String)
    case content
}
