//
//  SignedInViewModel.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
enum SignedInNavigationState {
	case home
	case profile
}
class SignedInViewModel: ObservableObject {
	// MARK: Dependencies
	
	// MARK: State
	@Published var navigationState: SignedInNavigationState = .home
	@Published var userSession: UserSession

	init(userSession: UserSession){
		self.userSession = userSession
	}
	
	// MARK: Task Methods
}
