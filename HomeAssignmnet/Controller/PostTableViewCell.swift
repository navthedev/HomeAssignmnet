//
//  PostTableViewCell.swift
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var postImage: UIImageView!
	@IBOutlet weak var likes: UILabel!
	@IBOutlet weak var comments: UILabel!
	private var urlString: String = ""
	var targetSize =  CGSize(width:0, height:0)
	
	
	// Setup post values
	func setCellWithValuesOf(_ post:Post) {
		updateUI(title: post.title, likes: post.likes, comments: post.comments, postImageString: post.postImageString)
		self.targetSize = CGSize(width: post.imageWidth ?? 0,height: post.imageHeight ?? 0)
	}
	// Update the UI Views
	private func updateUI(title: String?, likes: Int?, comments: Int?,postImageString: String?) {
		
		
		self.title.text = title
		self.likes.text = "\(likes?.roundedWithAbbreviations ?? "0") Likes"
		self.comments.text = "\(comments?.roundedWithAbbreviations ?? "0") Comments"
		
		guard let imageString = postImageString else {return}
		
		guard let posterImageURL = URL(string: imageString) else {
				print("noImageAvailable")
			return
		}
		
		// Before we download the image we clear out the old one
		self.postImage.image = nil
		
		getImageDataFrom(url: posterImageURL)
		
	}
	// MARK: - Get image data
	private func getImageDataFrom(url: URL) {
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			// Handle Error
			if let error = error {
				print("DataTask error: \(error.localizedDescription)")
				return
			}
			
			guard let data = data else {
				// Handle Empty Data
				print("Empty Data")
				return
			}
			
			DispatchQueue.main.async {
				if let image = UIImage(data: data) {
					self.postImage.image = image
//						.scalePreservingAspectRatio(
//						targetSize: self.targetSize)
				}
			}
		}.resume()
	}

}

extension UIImage {
	func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
		// Determine the scale factor that preserves aspect ratio
		let widthRatio = targetSize.width / size.width
		let heightRatio = targetSize.height / size.height
		
		let scaleFactor = min(widthRatio, heightRatio)
		
		// Compute the new image size that preserves aspect ratio
		let scaledImageSize = CGSize(
			width: size.width * scaleFactor,
			height: size.height * scaleFactor
		)

		// Draw and return the resized UIImage
		let renderer = UIGraphicsImageRenderer(
			size: scaledImageSize
		)

		let scaledImage = renderer.image { _ in
			self.draw(in: CGRect(
				origin: .zero,
				size: scaledImageSize
			))
		}
		
		return scaledImage
	}
}

extension Int {
	var roundedWithAbbreviations: String {
		let number = Double(self)
		let thousand = number / 1000
		let million = number / 1000000
		if million >= 1.0 {
			return "\(round(million*10)/10)M"
		}
		else if thousand >= 1.0 {
			return "\(round(thousand*10)/10)K"
		}
		else {
			return "\(self)"
		}
	}
}
