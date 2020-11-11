//
//  MovieVideo.swift
//  AssignmentBMS
//
//  Created by D2k on 06/11/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

struct MovieVideo : Codable {
    let id : String?
    let iso_639_1 : String?
    let iso_3166_1 : String?
    let key : String?
    let name : String?
    let site : String?
    let size : Int?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case iso_639_1 = "iso_639_1"
        case iso_3166_1 = "iso_3166_1"
        case key = "key"
        case name = "name"
        case site = "site"
        case size = "size"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        site = try values.decodeIfPresent(String.self, forKey: .site)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}

