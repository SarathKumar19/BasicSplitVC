//
//  SceneDelegate.swift
//  SplitVCPractice
//
//  Created by Sarath Kumar G on 05/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let _ = (scene as? UIWindowScene) else { return }
		guard
			let splitVC = self.window?.rootViewController as? SplitViewController,
			let primaryNC = splitVC.viewControllers.first as? UINavigationController,
			let primaryVC = primaryNC.topViewController as? PrimaryTableViewController,
			let secondaryNC = splitVC.viewControllers.last as? UINavigationController,
			let secondaryVC = secondaryNC.topViewController as? SecondaryViewController
		else {
			return
		}
		splitVC.delegate = self
		primaryVC.rowActionsDelegate = secondaryVC
		secondaryVC.rowSelected(atIndex: 0)
		secondaryVC.navigationItem.leftItemsSupplementBackButton = true
		secondaryNC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.

		// Save changes in the application's managed object context when the application transitions to the background.
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}

extension SceneDelegate: UISplitViewControllerDelegate {
	func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
		print("display mode changed to \(String(describing: displayMode))")
	}

	func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
		guard let secondaryAsNC = secondaryViewController as? UINavigationController else {
			return false
		}
		guard let topAsSecondaryVC = secondaryAsNC.topViewController as? SecondaryViewController else {
			return false
		}
		if topAsSecondaryVC.index == -1 {
			// Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
			return true
		}
		return false
	}
}
