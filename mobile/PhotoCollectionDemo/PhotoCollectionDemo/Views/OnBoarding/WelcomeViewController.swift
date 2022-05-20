//
//  WelcomeViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//

import Foundation
class WelcomeViewController: SwiftUIViewController<WelcomeView>{
	let goToLogInResponder: GoToLoginResponder
	let goToSignUpResponder: GoToSignUpResponder
	
	init(goToLogInResponder: GoToLoginResponder, goToSignUpResponder: GoToSignUpResponder){
		self.goToLogInResponder = goToLogInResponder
		self.goToSignUpResponder = goToSignUpResponder
		super.init(rootView: WelcomeView(goToLogInResponder: goToLogInResponder,
										goToSignUpResponder: goToSignUpResponder))
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
