//
//  DeviceTraitStatus.swift
//  SplitVCPractice
//
//  Created by Sarath Kumar G on 16/05/21.
//

import UIKit

enum DeviceTraitStatus {
	/// IPAD and others: Width: Regular, Height: Regular
	case wRhR_Portrait
	/// IPAD Landscape
	case wRhR_Landscape
	/// Any IPHONE Portrait Width: Compact, Height: Regular
	case wChR
	/// IPHONE Plus/Max Landscape Width: Regular, Height: Compact
	case wRhC
	/// IPHONE landscape Width: Compact, Height: Compact
	case wChC

	var isLandscape: Bool {
		return [.wRhR_Landscape, .wRhC, .wChC].contains(self)
	}

	var isLandscapeInIphone: Bool {
		return [.wRhC, .wChC].contains(self)
	}

	var isiPad: Bool {
		return [.wRhR_Portrait, .wRhR_Landscape].contains(self)
	}

	static func traitStatus(for window: UIWindow?) -> DeviceTraitStatus {
		guard let window = window else {
			return self.current
		}
		return self.traitStatus(for: window.traitCollection, withWindowSize: window.bounds.size)
	}
}

private extension DeviceTraitStatus {
	static var current: DeviceTraitStatus {
		let screen = UIScreen.main
		return self.traitStatus(for: screen.traitCollection, withWindowSize: screen.bounds.size)
	}

	static func traitStatus(
		for traitCollection: UITraitCollection,
		withWindowSize windowSize: CGSize
	) -> DeviceTraitStatus {
		switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
		case (.regular, .regular):
			// NOTE: In iPad landscape mode, when multiple windows are put side by side,
			// a window can be "wRhR_Landscape" only if it's width >= two third of screen width
			let hasTwoThirdScreenWidth = windowSize.width >= UIScreen.main.bounds.width * (2 / 3)
			if UIDevice.isLandscape, hasTwoThirdScreenWidth {
				return .wRhR_Landscape
			}
			return .wRhR_Portrait
		case (.compact, .regular):
			return .wChR
		case (.regular, .compact):
			return .wRhC
		case (.compact, .compact):
			return .wChC
		default:
			return .wChR
		}
	}
}

extension UIDevice {
	static var isLandscape: Bool {
		return UIDevice.current.orientation.isValidInterfaceOrientation
			? UIDevice.current.orientation.isLandscape
			: UIApplication.shared.statusBarOrientation.isLandscape
	}
}
