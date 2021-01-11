//
//  LayoutInCodeViewControllerTest.swift
//  HamcrestAutolayoutMatchersTest
//
//  Created by René Pirringer on 20.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers
@testable import Demo

class LayoutInCodeViewControllerTest: XCTestCase {
	
	var viewController: LayoutInCodeViewController!
	
	override func setUp() {
		super.setUp()
		viewController = LayoutInCodeViewController()
	}
	
	override func tearDown() {
		viewController = nil
		super.tearDown()
	}
	
	func test_has_proper_background() {
		// given
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.view.backgroundColor, presentAnd(equalToColor(.systemBackground)))
		
	}
	
	// MARK: titleLabel
	
	func test_titleLabel_uses_autolayout() {
		// whento
		viewController.loadViewIfNeeded()
		
		// then
		assertThat(viewController.titleLabel.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
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
	
	func test_subtitleLabel_uses_autolayout() {
		// when
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.subtitleLabel.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
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
	
	func test_buttomButton_uses_autolayout() {
		// when
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.bottomButton.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
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
	
	// MARK: centerButton
	
	
	func test_centerButton_uses_autolayout() {
		// when
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.centerButton.translatesAutoresizingMaskIntoConstraints, equalTo(false))
	}
	
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
	
}
