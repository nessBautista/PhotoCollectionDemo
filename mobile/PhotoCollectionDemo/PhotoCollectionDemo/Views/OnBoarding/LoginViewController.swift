//
//  LoginViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//

import Foundation
class LoginViewController: SwiftUIViewController<LoginView> {
	let viewModel: LoginViewModel
	
	init(viewModel: LoginViewModel) {
		self.viewModel = viewModel
		super.init(rootView: LoginView(viewModel: viewModel))
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
