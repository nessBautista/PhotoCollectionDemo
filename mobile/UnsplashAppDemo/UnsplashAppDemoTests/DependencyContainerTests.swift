//
//  DependencyContainerTests.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 09/03/22.
//

import XCTest
@testable import UnsplashAppDemo

class DependencyContainerTests: XCTestCase {
	var sut: DependencyContainer!
    override func setUpWithError() throws {
		try? super.setUpWithError()
        sut = DependencyContainer()
    }

    override func tearDownWithError() throws {
		sut = nil
		try? super.tearDownWithError()
    }

	// MARK: Views
	func test_makeMainView(){
		let mainView = sut.makeMainView()
		XCTAssertTrue((mainView as AnyObject) is MainView)
		//XCTAssertTrue((mainView.mainViewModel as AnyObject) is MainViewModel)
		XCTAssertTrue((mainView.launchViewFactory() as AnyObject) is LaunchView)
	}
	
	func test_makeLaunchView(){
		let launchView = sut.makeLaunchView()
		XCTAssertTrue((launchView as AnyObject) is LaunchView)
		XCTAssertTrue((launchView.launchViewModel as AnyObject) is LaunchViewModel)
	}
	
	func test_makeLaunchViewModel(){
		let vm = sut.makeLaunchViewModel()
		XCTAssertTrue((vm as AnyObject) is LaunchViewModel)
	}
	
	// MARK: Transitive
    func test_makeUserSessionCodable(){
		let userSessionCodable = sut.makeUserSessionCodable()
		XCTAssertTrue((userSessionCodable as AnyObject) is UserSessionCodable)
    }

}


