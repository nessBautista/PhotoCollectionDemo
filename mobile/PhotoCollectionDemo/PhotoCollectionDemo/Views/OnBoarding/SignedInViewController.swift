//
//  SignedInViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import UIKit
import Combine
class SignedInViewController: NiblessNavigationController {
	let viewModel: SignedInViewModel
	let homeViewController: HomeViewController
	private(set) var subscriptions = Set<AnyCancellable>()
	init(viewModel: SignedInViewModel, homewViewController: HomeViewController){
		self.viewModel = viewModel
		self.homeViewController = homewViewController
		
		super.init(rootViewController: homewViewController)
	}
	
	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	// MARK: Navigation
	private func present(_ screen: SignedInNavigationState) {
		switch screen {
		case .home:
			break
		case .profile:
			break
		}
	}
	// MARK: Bindings
	private func observeViewModel(){
		let publisher = viewModel.$navigationState
									.removeDuplicates()
									.eraseToAnyPublisher()
		self.subscribe(publisher)
			
			
	}
	private func subscribe(_ subscriber: AnyPublisher<SignedInNavigationState, Never>){
		subscriber
			.sink(receiveValue: { navigationState in
				self.present(navigationState)
			})
			.store(in: &subscriptions)
	}
}

