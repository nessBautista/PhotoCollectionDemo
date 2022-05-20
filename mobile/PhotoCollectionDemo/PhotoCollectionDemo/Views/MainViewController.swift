//
//  MainViewController.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import UIKit
import Combine
class MainViewController: NiblessViewController {
	//MARK: Properties
	private var subscriptions = Set<AnyCancellable>()
	private(set) var viewModel: MainViewModel
	
	var launchViewController: LaunchViewController
	var onBoardingViewController: OnBoardingViewController?
	var signedInViewController: SignedInViewController?
	
	var makeOnBoardingViewController:()->OnBoardingViewController
	var makeSignedInViewController:(UserSession)->SignedInViewController
	
	//MARK: Inits
	public init(viewModel: MainViewModel,
							launchViewController:LaunchViewController,
							onBoardingViewControllerFactory:@escaping()->OnBoardingViewController,
							singedInViewControllerFactory:@escaping(UserSession)->SignedInViewController){
		
		self.viewModel = viewModel
		self.launchViewController = launchViewController
		self.makeOnBoardingViewController = onBoardingViewControllerFactory
		self.makeSignedInViewController = singedInViewControllerFactory
		super.init()
	}
	
	
	
	//MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.observeViewModel()
    }
	
	//MARK: Navigation
	public func present(_ viewState: MainViewState){
		switch viewState {
		case .launching:
			self.presentLaunching()
		case .onboarding:
			if self.onBoardingViewController?.presentingViewController == nil {
				if self.presentedViewController.exists {
					self.dismiss(animated: true) { [weak self] in
						self?.presentOnBoarding()
					}
				} else {
					self.presentOnBoarding()
				}
			}
		case .signedIn(let session):
			print("Will PResent signed In")
			self.presentSignedIn(session: session)
		}
	}
	func presentLaunching(){
		addFullScreen(childViewController: launchViewController)
	}
	func presentOnBoarding() {
		//Creates onBoardingVC
		let onBoardingVC = makeOnBoardingViewController()
		onBoardingVC.modalPresentationStyle = .fullScreen
		// Present
		present(onBoardingVC, animated: true) { [weak self] in
			guard let stongSelf = self else { return }
			
			// Removes child view controllers (launcVC or SignedInVC)
			stongSelf.remove(childViewController: stongSelf.launchViewController)
			if let signedInViewController = stongSelf.signedInViewController {
				stongSelf.remove(childViewController: signedInViewController)
				stongSelf.signedInViewController = nil
			}
			
		}
		//Store reference
		self.onBoardingViewController = onBoardingVC
	}
	
	func presentSignedIn(session: UserSession){
		// Remove launchViewController if Necessary: (checks if it has a parent to know it is presented)
		remove(childViewController: launchViewController)
		
		//Get the SignedInVC: Check weather the SignedInVC is already created (but not presented)
		let signedInVCToPresent: SignedInViewController
		if let vc = self.signedInViewController {
			signedInVCToPresent = vc
		} else {
			//Create it and store the reference
			signedInVCToPresent = makeSignedInViewController(session)
			self.signedInViewController = signedInVCToPresent
		}
		
		// Present it
		addFullScreen(childViewController: signedInVCToPresent)
		
		// Remove OnBOardingVC if necessary
		if onBoardingViewController?.presentingViewController != nil {
			onBoardingViewController = nil
			dismiss(animated: true)
		}
	}
	
	//MARK: Bindings
	func observeViewModel(){
		let subscriber = self.viewModel
								.$mainViewState
								.removeDuplicates()
								.eraseToAnyPublisher()
		self.subscribe(subscriber)
		
	}

	func subscribe(_ subscriber: AnyPublisher<MainViewState, Never>){
		subscriber
			.receive(on: RunLoop.main)
			.sink { mainViewState in
				self.present(mainViewState)
			}
			.store(in: &subscriptions)
	}
}

