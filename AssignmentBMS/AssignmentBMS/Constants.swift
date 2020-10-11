//
//  Constants.swift
//  AssignmentBMS
//
//  Created by Ajay on 10/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation
import UIKit

//MARK: String Constants
enum Strings {
    static let moviesDBTitle = "Movies DB"
    static let placeholder = "Search movie name..."
    
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let retry = "Retry"
    static let error = "Error"
    static let close = "close"
    static let recentSearch = "Recently Searched Movies"
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
}
    
enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let numberOfColumns: CGFloat = 1
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 20
}

//MARK: ViewState
public enum ViewState: Equatable {
    case none
    case loading
    case error(String)
    case content
}
