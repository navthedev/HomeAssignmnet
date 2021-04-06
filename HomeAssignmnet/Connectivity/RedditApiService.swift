//
//  RedditApiService.swift
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

import Foundation

class RedditApiService {
	
	private let session: URLSession
	private let decoder: JSONDecoder
	
	init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
		self.session = session
		self.decoder = decoder
	}
	
	func getJSONData(completion: @escaping (Result<[Post], Error>) -> Void) {
		let redditDataURL = "https://www.reddit.com/.json"
		
		guard let url = URL(string: redditDataURL) else {return}
		
		session.dataTask(with: url) { [weak self] data, _, error in
			if let error = error {
				completion(.failure(error))
			}
			else {
				do {
					let data = data ?? Data()
					let response = try self?.decoder.decode(Listing.self, from: data)
					
					// Back to the main thread
					DispatchQueue.main.async {
						completion(.success(response?.posts ?? []))
					}
				}
				catch {
					completion(.failure(error))
				}
			}
		}.resume()
	}
}
