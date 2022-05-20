//
//  LoginViewModel.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 08/04/22.
//

import Foundation
import WebKit
import Combine

/* Comment: You don't have much control on The login view model
 It's up to the user to perform login and grant permissions
 You do need to be alert in case the UserSession Creation
 is triggered by an Access Token Creation.
 */

class LoginViewModel: NSObject {
	
	private var subscriptions = Set<AnyCancellable>()
	
	//MARK: Dependencies
	let signedInResponder: SignedInResponder
	let userSessionRepository: UserSessionRepository
	
	
	//MARK: State
	//..
		
	init(userSessionRepository: UserSessionRepository,
		 signedInResponder: SignedInResponder) {
		self.userSessionRepository = userSessionRepository
		self.signedInResponder = signedInResponder
	}
	
	//MARK: Task Methods
	
	// Construct the Request required to perform the OAuth in Unsplash
	func getAuthorizeEndPoint() -> UnsplashAuthEndpoint {
		userSessionRepository.getAuthorizeEndPoint()
	}
	
	//
	func createUserSession(authCode: String){
		self.userSessionRepository.createUserSession(authCode:authCode)
			.sink { completion in
				if case .failure(let error) = completion {
					print("Do something with:\(error)")
				}
			} receiveValue: { session in
				self.signedInResponder.signedIn(session: session)
			}.store(in: &subscriptions)
	}
}

// MARK: Monitor navigation to get the token response
extension LoginViewModel: WKNavigationDelegate {
	func webView(_ webView: WKWebView,
				 decidePolicyFor navigationResponse: WKNavigationResponse)
				async -> WKNavigationResponsePolicy {
		let response = navigationResponse					
		if let code =  self.processCode(response: response) {
			AppLogger.shared.log(log: "User Triggered new User Session Creation")
			self.createUserSession(authCode: code)
			return .cancel
		}
		return .allow
	}
	
	private func processCode(response: WKNavigationResponse) -> String? {
		guard let url = response.response.url else { return nil}
		guard let query = url.query, query.contains("code") else {return nil}
		let components = query.split(separator: "=")
		if components.count == 2 {
			return String(components[1])
		}
		return nil
	}
}
