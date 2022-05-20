//
//  TestDependencyContainer.swift
//  PhotoCollectionDemoTests
//
//  Created by Nestor Hernandez on 06/04/22.
//

import XCTest
@testable import PhotoCollectionDemo
class TestDependencyContainer: XCTestCase {

	var sut: DependencyContainer?
    override func setUpWithError() throws {
		self.sut = DependencyContainer()
    }

    override func tearDownWithError() throws {
		self.sut = nil
    }

	
	
}
