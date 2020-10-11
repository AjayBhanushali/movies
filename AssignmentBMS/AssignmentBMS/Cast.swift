/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Cast : Codable {
	let cast_id : Int?
	let character : String?
	let credit_id : String?
	let gender : Int?
	let id : Int?
	let name : String?
	let order : Int?
	let profile_path : String?

	enum CodingKeys: String, CodingKey {

		case cast_id = "cast_id"
		case character = "character"
		case credit_id = "credit_id"
		case gender = "gender"
		case id = "id"
		case name = "name"
		case order = "order"
		case profile_path = "profile_path"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cast_id = try values.decodeIfPresent(Int.self, forKey: .cast_id)
		character = try values.decodeIfPresent(String.self, forKey: .character)
		credit_id = try values.decodeIfPresent(String.self, forKey: .credit_id)
		gender = try values.decodeIfPresent(Int.self, forKey: .gender)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		order = try values.decodeIfPresent(Int.self, forKey: .order)
		profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
	}

}