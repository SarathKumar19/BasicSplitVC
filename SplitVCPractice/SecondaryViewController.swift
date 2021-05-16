//
//  SecondaryViewController.swift
//  SplitVCPractice
//
//  Created by Sarath Kumar G on 05/05/21.
//

import UIKit

protocol RowActions: AnyObject {
	func rowSelected(atIndex index: Int)
}

class SecondaryViewController: UIViewController {
	@IBOutlet private var textLabel: UILabel!

	var index = -1 {
		didSet {
			self.refreshUI()
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension SecondaryViewController {
	func refreshUI() {
		self.loadViewIfNeeded()
		self.textLabel.text = "Detail view for Row \(self.index + 1)"
	}
}

// MARK: - SecondaryViewController + RowActions

extension SecondaryViewController: RowActions {
	func rowSelected(atIndex index: Int) {
		self.index = index
	}
}
