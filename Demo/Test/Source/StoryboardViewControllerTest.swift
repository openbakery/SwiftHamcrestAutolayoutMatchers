//
//  StoryboardViewControllerTest.swift
//  Tests
//
//  Created by René Pirringer on 19.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers
@testable import Demo

class StoryboardViewControllerTest: XCTestCase {

	var viewController: StoryboardViewController!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let viewController = storyboard.instantiateViewController(identifier: "StoryboardViewController") as? StoryboardViewController {
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
	
	// MARK: titleLabel
	
	func test_has_titleLabel() {
		// given
		viewController.loadViewIfNeeded()
		
		// when
		let label = viewController.titleLabel
		
		// then
		assertThat(label, present())
	}
	
	func test_titleLabel_layout() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.titleLabel, presentAnd(isEqualCenterX()))
		assertThat(viewController.titleLabel, presentAnd(isPinnedToSafeAreaAnchor(.top)))
	}
	
	
	// MARK: subtitleLabel

	
	func test_has_subtitleLabel() {
		// given
		viewController.loadViewIfNeeded()
		
		// when
		let label = viewController.subtitleLabel
		
		// then
		assertThat(label, present())
	}
	
	func test_subtitleLabel_layout() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.subtitleLabel, presentAnd(isPinned(.leading, gap: 40)))
		assertThat(viewController.subtitleLabel, presentAnd(isPinned(.top, toView: viewController.titleLabel, gap: 20)))
	}
	
	
	// MARK: buttomButton
	
	func test_has_bottomButton() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.bottomButton, present())
	}
	
	func test_buttomButton_layout() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.bottomButton, presentAnd(isPinnedToSafeAreaAnchor(.bottom, gap: 40)))
		assertThat(viewController.bottomButton, presentAnd(isPinnedToSafeAreaAnchor(.trailing, gap: 40)))
		
	}
	
	
	func test_buttomButton_pressed_shows_LayoutInCodeViewController() {
		// given
		let navigationController = TestNavigationController(rootViewController: viewController)
		navigationController.loadViewIfNeeded()
		
		// when
		viewController.bottomButton?.sendActions(for: .touchUpInside)
		
		// then
		assertThat(navigationController.viewControllers, hasCount(2))
		assertThat(navigationController.viewControllers.last, presentAnd(instanceOf(LayoutInCodeViewController.self)))

	}

	// MARK: centerButton
	
	func test_has_centerButton() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.centerButton, present())
	}
	
	func test_centerButton_layout() {
		// when
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.centerButton, presentAnd(isEqualCenterY(offset: 40)))
		assertThat(viewController.centerButton, presentAnd(isEqualCenterX()))
	}
	
	func test_centerButton_pressed_shows_PinLayoutViewController() {
		// given
		let navigationController = TestNavigationController(rootViewController: viewController)
		navigationController.loadViewIfNeeded()
		
		// when
		viewController.centerButton?.sendActions(for: .touchUpInside)
		
		// then
		assertThat(navigationController.viewControllers, hasCount(2))
		assertThat(navigationController.viewControllers.last, presentAnd(instanceOf(PinLayoutViewController.self)))

	}
	
}
