//
//  AppDelegate.swift
//  PerformanceVisibility
//
//  Created by Nestor Hernandez on 13/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let container = DependencyContainer()
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = container.makeMainViewController()
		window?.makeKeyAndVisible()
		return true
	}

	

}

