//
//  MovieVideosBase.swift
//  AssignmentBMS
//
//  Created by D2k on 06/11/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

struct MovieVideosBase : Codable {
    let id : Int?
    let results : [MovieVideo]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        results = try values.decodeIfPresent([MovieVideo].self, forKey: .results)
    }

}
