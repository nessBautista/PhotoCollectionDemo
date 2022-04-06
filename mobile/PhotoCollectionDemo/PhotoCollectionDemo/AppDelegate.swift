//
//  AppDelegate.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 31/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		self.window = UIWindow(frame: UIScreen.main.bounds)
		let vc = ViewController()
		let navController = UINavigationController(rootViewController: vc)
		self.window?.rootViewController = navController
		
		self.window?.makeKeyAndVisible()
		return true
	}
}

