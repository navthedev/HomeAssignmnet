//
//  ViewController.swift
//  HomeAssignmnet
//
//  Created by Navjot Singh  on 05/04/21.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	var viewModel = ListingViewModel()
	var detailViewController = DetailViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		loadRedditData()
	}
	
	private func loadRedditData() {
		viewModel.fetchListings { [weak self] in
			self?.tableView.dataSource = self
			self?.tableView.reloadData()
		}
	}
	
	
	
}

// MARK: - TableView
extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
		
		let post = viewModel.cellForRowAt(indexPath: indexPath)
		cell.setCellWithValuesOf(post)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.performSegue(withIdentifier: "detailSegue", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "detailSegue") {
			if let detailView = segue.destination as? DetailViewController {
				let indexPath = self.tableView.indexPathForSelectedRow
				let post = viewModel.cellForRowAt(indexPath: indexPath!)
				detailView.webURL = post.webUrl ?? "https://www.google.com"
			}
		}
	}
}
