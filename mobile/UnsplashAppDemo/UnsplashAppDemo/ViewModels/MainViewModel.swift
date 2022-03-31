//
//  MainViewModel.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 06/03/22.
//

import Foundation
enum NavigationState {
	case launching
	case loggedIn
	case notLoggedIn
}
class MainViewModel: ObservableObject{
	@Published var navigationState: NavigationState = .launching
}

extension MainViewModel: UserSessionNavigationResponder {
	func navigationActionLogIn() {
		self.navigationState = .loggedIn
	}
	
	func navigationActionNotLogIn(){
		self.navigationState = .notLoggedIn
	}
}
