//
//  DependencyContainer.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import Foundation
class DependencyContainer {
	
	//MARK: Long-Lived Dependencies
	let sharedUserSessionRepository: UserSessionRepository
	let sharedMainViewModel: MainViewModel
	let sharedOnBoardingViewModel: OnBoardingViewModel
	
	public init() {
		func makeUserSessionRepository()->UserSessionRepository {
			let networkLayer = makeRemoteAuthAPI()
			let storageLayer = makeUserSessionDataStore()
			
			return UserSessionRepository(networkLayer: networkLayer,
										storageLayer: storageLayer)
		}
		func makeRemoteAuthAPI()-> AuthRemoteAPI {
			let session = makeURLSession()
			let appSettings = makeAppSettings()
			return UnsplashRemoteAuthAPI(session: session,
										 appSettings: appSettings)
		}
		func makeURLSession()-> Transport {
			URLSession.shared
		}
		
		func makeAppSettings()-> AppSettingsProtocol {
			let plistReader = makePlistReader()
			return AppSettings(plistReader: plistReader)
		}
		
		func makePlistReader()->PlistReaderProtocol{
			APIConfigPlistReader(fileName: "AppConfig")
		}
		func makeUserSessionDataStore()->UserSessionDataStore {
			UserDefaultsUserSessionStore()
		}
		func makeOnBoardingViewModel()->OnBoardingViewModel {
			OnBoardingViewModel()
		}
		
		self.sharedUserSessionRepository = makeUserSessionRepository()
		self.sharedOnBoardingViewModel = makeOnBoardingViewModel()
		self.sharedMainViewModel = MainViewModel()
		
	}
	
	func makeMainViewController() -> MainViewController {
		let launchVC = makeLaunchViewController()
		let onBoardingViewControllerFactory = {
			return self.makeOnBoardingViewController()
		}
		
		let singedInViewControllerFactory = { (userSession:UserSession) in
			return self.makeSignedInViewController(session: userSession)
		}
		
		return MainViewController(viewModel: sharedMainViewModel,
						   launchViewController: launchVC,
						   onBoardingViewControllerFactory: onBoardingViewControllerFactory,
						   singedInViewControllerFactory: singedInViewControllerFactory)
	}
	
	func makeLaunchViewController()->LaunchViewController {
		LaunchViewController(viewModel: makeLaunchViewModel())
	}
	
	//MARK: Onboarding
	func makeOnBoardingViewController() -> OnBoardingViewController {
		return OnBoardingViewController(viewModel: sharedOnBoardingViewModel,
										welcomeViewController: makeWelcomeViewController(),
										loginViewController: makeLoginViewController(),
										signUpViewController: makeSignUpViewController())
	}
	
	func makeWelcomeViewController() -> WelcomeViewController{
		WelcomeViewController(goToLogInResponder: sharedOnBoardingViewModel,
							  goToSignUpResponder: sharedOnBoardingViewModel)
	}
	
	func makeSignUpViewController() -> SignUpViewController {
		SignUpViewController()
	}
	
	func makeLoginViewController() -> LoginViewController {
		let vm = makeLoginViewModel()
		return LoginViewController(viewModel: vm)
	}
	
	func makeLoginViewModel() -> LoginViewModel {
		return LoginViewModel(userSessionRepository: sharedUserSessionRepository,
					   signedInResponder: sharedMainViewModel)
	}
	
	//MARK: Signed IN
	func makeSignedInViewController(session: UserSession) -> SignedInViewController {
		let signedInViewModel = makeSignedInViewModel(session: session)
		let homeVC = makeHomeViewController(apiSession: session.accessToken)
		return SignedInViewController(viewModel: signedInViewModel,
									  homewViewController: homeVC)
	}
	
	func makeHomeViewController(apiSession:AccessToken) -> HomeViewController {
		let homeViewModel = makeHomeViewModel(apiSession: apiSession)
		return HomeViewController(viewModel: homeViewModel)
	}
	
	func makeHomeViewModel(apiSession: AccessToken)-> HomeViewModel {
		let photosRepo = makePhotosRepository(apiSession: apiSession)
		let imageLoader = makeImageLoader()
		return HomeViewModel(photosRepository: photosRepo,
							 imageLoader: imageLoader)
	}
	func makeImageLoader() -> ImageLoader {
		HomeImageLoader()
	}
	
	func makeSignedInViewModel(session: UserSession)-> SignedInViewModel {
		SignedInViewModel(userSession: session)
	}
	func makeLaunchViewModel()->LaunchViewModel{
		LaunchViewModel(userSessionRepo: self.sharedUserSessionRepository,
						notSignedInResponder: self.sharedMainViewModel,
						signedInResponder: self.sharedMainViewModel)
	}
	
	func makePhotosRepository(apiSession: AccessToken)-> PhotosRepositoryProtocol {
		let photosAPI = self.makePhotoAPI(apiSession: apiSession)
		return PhotosRepository(photosAPI: photosAPI)
	}
	
	func makePhotoAPI(apiSession: AccessToken)-> PhotosAPI {
		let session = makeURLSession()
		return UnsplashPhotosAPI(session: session, apiSession: apiSession)
	}
	
	func makeURLSession()->URLSession{
		URLSession.shared
	}
}

extension DependencyContainer {
	func makeNetworkLayer(){
		
	}
}
