//
//  StoryboardViewControllerTest.swift
//  Tests
//
//  Created by René Pirringer on 19.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import XCTest
import Demo

class StoryboardViewControllerTest: XCTestCase {

	var viewController: StoryboardViewController!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let viewController = storyboard.instantiateInitialViewController() as? StoryboardViewController {
			self.viewController = viewController
		} else {
			XCTFail("Cannot create StoryboardViewController")
			self.viewController = StoryboardViewController()
		}
	}
	
	override func tearDown() {
		viewController = nil
		super.tearDown()
	}
	
	func test_has_titleLabel() {
		viewController.loadViewIfNeeded()
	}

}
