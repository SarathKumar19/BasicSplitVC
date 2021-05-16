//
//  PrimaryTableViewController.swift
//  SplitVCPractice
//
//  Created by Sarath Kumar G on 05/05/21.
//

import UIKit

class PrimaryTableViewController: UITableViewController {
	private final let cellId = "PrimaryTableViewCell"

	weak var rowActionsDelegate: RowActions?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
		cell.textLabel?.text = "Row \(indexPath.row + 1)"
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.rowActionsDelegate?.rowSelected(atIndex: indexPath.row)
		if let secondaryVC = self.rowActionsDelegate as? SecondaryViewController {
			self.splitViewController?.showDetailViewController(secondaryVC, sender: nil)
		}
	}
}
