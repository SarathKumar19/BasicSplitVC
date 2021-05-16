//
//  SplitViewController.swift
//  SplitVCPractice
//
//  Created by Sarath Kumar G on 05/05/21.
//

import UIKit

class SplitViewController: UISplitViewController {
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		// Default value is "allButUpsideDown"
		return .all // To support ".portratiUpsideDown" orientation
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		self.customizeSplitVC()
    }

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		coordinator.animate { _ in
			self.customizeSplitVC()
		}
	}
}

private extension SplitViewController {
	func customizeSplitVC() {
		// NOTE: Set 'preferredDisplayMode' to ".oneBesideSecondary" and
		// 'preferredSplitBehavior' to ".tile", in order to force SplitVC to display all VCs
		let traitStatus = WindowTraitStatus.traitStatus(for: self.view.window)
		self.preferredDisplayMode = traitStatus.isLandscape ? .oneBesideSecondary : .automatic
		self.preferredSplitBehavior = traitStatus.isLandscape ? .tile : .automatic
		if traitStatus.isiPad {
			self.maximumPrimaryColumnWidth = 320
		}
	}
}
