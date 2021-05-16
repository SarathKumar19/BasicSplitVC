//
//  DeviceTraitStatus.swift
//  SplitVCPractice
//
//  Created by Sarath Kumar G on 16/05/21.
//

import UIKit

enum WindowTraitStatus {
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

	static func traitStatus(for window: UIWindow?) -> WindowTraitStatus {
		guard let window = window, let windowScene = window.windowScene else {
			return self.screenTraitStatus
		}
		return self.traitStatus(
			for: window.traitCollection,
			withWindowSize: window.bounds.size,
			isLandscape: windowScene.interfaceOrientation.isLandscape
		)
	}
}

private extension WindowTraitStatus {
	static var screenTraitStatus: WindowTraitStatus {
		let screen = UIScreen.main
		return self.traitStatus(
			for: screen.traitCollection,
			withWindowSize: screen.bounds.size,
			isLandscape: UIDevice.current.orientation.isLandscape
		)
	}

	static func traitStatus(
		for traitCollection: UITraitCollection,
		withWindowSize windowSize: CGSize,
		isLandscape: Bool
	) -> WindowTraitStatus {
		switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
		case (.regular, .regular):
			// NOTE: In iPad landscape mode, when multiple windows are put side by side,
			// a window can be "wRhR_Landscape" only if it's width >= two third of screen width
			let hasTwoThirdScreenWidth = windowSize.width >= UIScreen.main.bounds.width * (2 / 3)
			if UIDevice.current.orientation.isLandscape, hasTwoThirdScreenWidth {
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
