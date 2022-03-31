//
//  LaunchViewModel.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 09/03/22.
//

import Foundation
import Combine

class LaunchViewModel {
	var authRepo: AuthUserSessionRepo
	var navigationResponder: UserSessionNavigationResponder
	var subscriptions = Set<AnyCancellable>()
	
	init(authRepo: AuthUserSessionRepo,
		 navigationResponder:UserSessionNavigationResponder) {
		self.authRepo = authRepo
		self.navigationResponder = navigationResponder
	}
	
	func fetchUserSession(){
		self.authRepo
			.fetchUserSession()
			.sink { completion in
				print(completion)
			} receiveValue: { usersSesion in
				if usersSesion != nil {
					self.navigationResponder.navigationActionLogIn()
				} else {
					self.navigationResponder.navigationActionNotLogIn()
				}
			}.store(in: &subscriptions)
	}
}
