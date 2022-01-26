//
//  PinLayoutViewControllerTest.swift
//  HamcrestAutolayoutMatchersTest
//
//  Created by René Pirringer on 20.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers
import PinLayout
@testable import Demo

class PinLayoutViewControllerTest: XCTestCase {
	
	var viewController: PinLayoutViewController!
	
	override func setUp() {
		super.setUp()
		viewController = PinLayoutViewController()
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


	// MARK: - Center

	func test_centerButton_is_equal_center() {
		// when
		viewController.loadViewIfNeeded()

		// then
		assertThat(viewController.centerButton, presentAnd(isEqualCenterX()))
	}

	func test_view_is_equal_center() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.equalCenter(view: centerView)

		// then
		assertThat(centerView, isEqualCenterX())
		assertThat(centerView, isEqualCenterY())
		assertThat(centerView, isEqualCenter())
	}


	func test_view_is_equal_horizontal_center_with_offset() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.equalCenterX(view: centerView, offset: 20)

		// then
		assertThat(centerView, isEqualCenterX(offset: 20))
	}


	func test_view_is_equal_horizontal_center_with_bottomButton() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.equalCenterX(view: centerView, toView: viewController.bottomButton)

		// then
		assertThat(centerView, isEqualCenterX(with: viewController.bottomButton))
	}


	func test_view_is_equal_vertical_center_with_offset() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.equalCenterY(view: centerView, offset: 20)

		// then
		assertThat(centerView, isEqualCenterY(offset: 20))
	}


	func test_view_is_equal_vertical_center_with_bottomButton() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.equalCenterY(view: centerView, toView: viewController.bottomButton)

		// then
		assertThat(centerView, isEqualCenterY(with: viewController.bottomButton))
	}

	// MARK: - Horizontal Save Area


	func test_view_is_safeArea_horizontal_center() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.centerX(view: centerView)

		// then
		assertThat(centerView, isCenterX())
	}

	func test_view_is_safeArea_horizontal_center_with_low_priority() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.centerX(view: centerView)?.priority = .defaultLow

		// then
		assertThat(centerView, isCenterX(priority: .defaultLow))
	}

	func test_view_is_safeArea_vertical_center() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.centerY(view: centerView)

		// then
		assertThat(centerView, isCenterY())
	}

	func test_view_is_safeArea_vertical_center_with_low_priority() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.centerY(view: centerView)?.priority = .defaultLow

		// then
		assertThat(centerView, isCenterY(priority: .defaultLow))
	}

	func test_view_is_safeArea_center() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		viewController.view.addSubview(centerView)
		let layout = PinLayout()

		// when
		layout.center(view: centerView)

		// then
		assertThat(centerView, isCenterY())
		assertThat(centerView, isCenterX())
		assertThat(centerView, isCenter())
	}
	
	func test_view_is_safeArea_center_with_other_view() {
		// given
		viewController.loadViewIfNeeded()
		let centerView = UIView()
		let otherView = UIView()
		viewController.view.addSubview(centerView)
		viewController.view.addSubview(otherView)
		let layout = PinLayout()

		// when
		layout.centerY(view: centerView, with: otherView)
		layout.centerX(view: centerView, with: otherView)

		// then
		assertThat(centerView, isCenterY(with:otherView))
		assertThat(centerView, isCenterX(with:otherView))
		assertThat(centerView, isCenter(with:otherView))
	}

}
