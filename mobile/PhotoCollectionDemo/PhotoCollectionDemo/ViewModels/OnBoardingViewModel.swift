//
//  OnBoardingViewModel.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import Foundation
public enum OnBoardingScreen {
	case welcome
	case login
	case signup
}
class OnBoardingViewModel {
	@Published private(set) var screen: OnBoardingScreen = .welcome
	
}
//extension OnBoardingViewModel: SignedInResponder {
//	func signedIn(session: UserSession) {
//		self.screen = .login
//	}
//}

extension OnBoardingViewModel: GoToLoginResponder {
	func goToLogin() {
		self.screen = .login
	}
}
extension OnBoardingViewModel: GoToSignUpResponder {
	func goToSignUp() {
		self.screen = .signup
	}
}
