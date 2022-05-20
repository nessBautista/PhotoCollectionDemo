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
	let container: DependencyContainer = DependencyContainer()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = container.makeMainViewController()
		self.window?.makeKeyAndVisible()
		return true
	}
}

