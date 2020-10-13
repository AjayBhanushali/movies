//
//  APIEndPoint.swift
//  AssignmentBMS
//
//  Created by Ajay on 10/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol APIEndPoint: URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String]? { get }
}

extension APIEndPoint {
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}

