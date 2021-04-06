//
//  ListingViewModel.swift
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

import Foundation

class ListingViewModel{
	
	private var apiService = RedditApiService()
	private var posts = [Post]()
	
	func fetchListings(completion: @escaping () -> ()) {
		// weak self - prevent retain cycles
		apiService.getJSONData{ [weak self] (result) in
			DispatchQueue.main.async {
				switch result {
				case .success(let posts):
					self?.posts = posts
					completion()
				case .failure(let error):
					// Something is wrong with the JSON file or the model
					print("Error processing json data: \(error)")
				}
			}
		}
	}
	func numberOfRowsInSection(section: Int) -> Int {
		if posts.count != 0 {
			return posts.count
		}
		return 0
	}
	
	func cellForRowAt (indexPath: IndexPath) -> Post {
		return posts[indexPath.row]
	}
}
