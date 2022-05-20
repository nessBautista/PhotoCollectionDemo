//
//  DependencyContainer.swift
//  PerformanceVisibility
//
//  Created by Nestor Hernandez on 13/04/22.
//

import Foundation

class DependencyContainer {
	let mainViewModel: MainViewModel
	init(){
		self.mainViewModel = MainViewModel()
	}
	
	func makeMainViewController() -> MainViewController {
		return MainViewController(viewModel: self.mainViewModel)
	}
}
