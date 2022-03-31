//
//  MainViewModelTest.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 06/03/22.
//

import XCTest
@testable import UnsplashAppDemo
class MainViewModelTest: XCTestCase {
	let dependencyContainer: DependencyContainer = DependencyContainer()
	var sut: MainViewModel!
	
	override func setUpWithError() throws {
		try! super.setUpWithError()
		self.sut = dependencyContainer.sharedMainViewModel
	}
	
	override func tearDownWithError() throws {
		try! super.tearDownWithError()
	}
	
	
	func test_initialState_is_launchScreen(){
		XCTAssertEqual(self.sut.navigationState, .launching)
	}
	
	//MARK: Navigation Responder
	func test_is_UserSessionNavigationResponder(){
		XCTAssertTrue((sut as AnyObject)  is UserSessionNavigationResponder)
	}
	
	func test_whenUserLogsIn_NavStateIsLogIn(){
		// When
		sut.navigationActionLogIn()
		// Then
		XCTAssertEqual(self.sut.navigationState, .loggedIn)
	}
	
	func test_whenUserIsNotLoggedIn_NavStateIsNotLoggedIn(){
		// When
		sut.navigationActionNotLogIn()
		// Then
		XCTAssertEqual(self.sut.navigationState, .notLoggedIn)
	}
	
}
