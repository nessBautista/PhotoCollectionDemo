//
//  MainViewModel.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import Foundation
import Combine

class MainViewModel {
	@Published var mainViewState: MainViewState = .launching
	
}
extension MainViewModel: NotSignedInResponder {
	func notSignedIn() {
		self.mainViewState = .onboarding
	}
}
extension MainViewModel: SignedInResponder {
	func signedIn(session: UserSession) {
		self.mainViewState = .signedIn(session: session)
	}
}
