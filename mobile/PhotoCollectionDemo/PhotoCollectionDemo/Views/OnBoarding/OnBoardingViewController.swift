//
//  OnBoardingViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import UIKit
import Combine

class OnBoardingViewController: NiblessNavigationController {
	//MARK: variables
	private(set) var subscriptions = Set<AnyCancellable>()
	let viewModel: OnBoardingViewModel
	let welcomeViewController: WelcomeViewController
	let loginViewController: LoginViewController
	let signUpViewController: SignUpViewController
	
	//MARK: Init
	public init(viewModel: OnBoardingViewModel,
				welcomeViewController: WelcomeViewController,
				loginViewController: LoginViewController,
				signUpViewController: SignUpViewController) {
		self.viewModel = viewModel
		self.welcomeViewController = welcomeViewController
		self.loginViewController = loginViewController
		self.signUpViewController = signUpViewController
		super.init()
	}
	
	//MARK: life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
		self.obserViewModel()
    }
	
	//MARK: bindings
	func obserViewModel(){
		let publisher = self.viewModel.$screen.removeDuplicates().eraseToAnyPublisher()
		self.subscribe(publisher)
	}
	
	func subscribe(_ publisher: AnyPublisher<OnBoardingScreen, Never>) {
		publisher
			.sink { screen in
				self.present(screen: screen)
		}
		.store(in: &subscriptions)
	}
	
	//MARK: Navigation
	func present(screen: OnBoardingScreen){
		switch screen {
		case .welcome:
			self.presentWelcome()
		case .login:
			self.presentLogin()
		case .signup:
			presentSignUp()
		}
	}
	
	func presentWelcome() {
	  pushViewController(welcomeViewController, animated: false)
	}

	func presentLogin() {
	  pushViewController(loginViewController, animated: true)
	}

	func presentSignUp() {
	  pushViewController(signUpViewController, animated: true)
	}
}
