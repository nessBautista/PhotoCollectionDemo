//
//  NavigationResponders.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import Foundation
protocol NotSignedInResponder {
	func notSignedIn()
}

protocol SignedInResponder {
	func signedIn(session: UserSession)
}

protocol GoToLoginResponder {
	func goToLogin()
}
protocol GoToSignUpResponder {
	func goToSignUp()
}
