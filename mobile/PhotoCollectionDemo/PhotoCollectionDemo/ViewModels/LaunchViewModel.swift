//
//  LaunchViewModel.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import Foundation
import Combine

class LaunchViewModel {
	var userSessionRepo: UserSessionRepository
	var notSignedInResponder: NotSignedInResponder
	var signedInResponder: SignedInResponder
	
	private(set) var subscriptions = Set<AnyCancellable>()
	
	init(userSessionRepo: UserSessionRepository,
		 notSignedInResponder: NotSignedInResponder,
		 signedInResponder: SignedInResponder) {
		self.userSessionRepo = userSessionRepo
		self.notSignedInResponder = notSignedInResponder
		self.signedInResponder = signedInResponder
	}
	
	func loadUserSession() {
		userSessionRepo
			.readUserSession()
			.receive(on: DispatchQueue.main)
			.sink { completion in
				if case .failure(.emptySession(let message)) = completion {
					print("error:\(message)")
					self.notSignedInResponder.notSignedIn()
				}
				
			} receiveValue: { userSession in
				self.signedInResponder.signedIn(session: userSession)
			}
			.store(in: &subscriptions)
	}
}
