//
//  Post.swift
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

import Foundation

struct Post: Decodable {
	
	let title: String?
	let body: String?
	let likes: Int?
	let comments: Int?
	let postImageString: String?
	let webUrl: String?
	let imageHeight: Int?
	let imageWidth: Int?
	
	private enum CodingKeys: String, CodingKey {
		case title = "title"
		case body = "author"
		case likes = "ups"
		case comments = "num_comments"
		case postImageString = "thumbnail"
		case webUrl = "url"
		case imageHeight = "thumbnail_height"
		case imageWidth = "thumbnail_width"
		case data
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
		
		title = try dataContainer.decode(String.self, forKey: .title)
		body = try dataContainer.decode(String.self, forKey: .title)
		likes = try dataContainer.decode(Int.self, forKey: .likes)
		comments = try dataContainer.decode(Int.self, forKey: .comments)
		imageHeight = try dataContainer.decodeIfPresent(Int.self, forKey: .imageHeight)
		imageWidth = try dataContainer.decodeIfPresent(Int.self, forKey: .imageWidth)
		postImageString = try dataContainer.decode(String.self, forKey: .postImageString)
		webUrl = try dataContainer.decode(String.self, forKey: .webUrl)
	}
}
