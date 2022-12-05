//
// Created by René Pirringer.
// Copyright (c) 2022 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import PinLayout
import UIKit
import Hamcrest
@testable import HamcrestAutolayoutMatchers

@available(iOS 11, *)
class Constraint_Pin_Test: XCTestCase {

	var view : UIView!
	var toView : UIView!
	var pinLayout: Layout!

	override func setUp() {
		super.setUp()
		view = UIView()
		toView = UIView()
		pinLayout = Layout()
	}

	override func tearDown() {
		view = nil
		toView = nil
		pinLayout = nil
		super.tearDown()
	}

	func test_pin_leading_with_readableGuide() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.leadingReadable)
		assertThat(view, isPinnedToReadableAnchor(.leading))
		assertThat(view, not(isPinned(.leading)))
	}

	func test_pin_trailing_with_readableGuide() {
		let view1 = UIView()
		let view2 = UIView()
		NSLog("view1 \(view1)")
		NSLog("view2 \(view2)")
		NSLog("contraintsCount \(view1.constraints.count)")
		view1.addSubview(view2)
		NSLog("contraintsCount \(view1.constraints.count)")
		pinLayout.pin(view:view2, to:.trailingReadable)
		assertThat(view2, isPinnedToReadableAnchor(.trailing))
		assertThat(view, not(isPinned(.trailing)))
	}


	func test_pin_leading_with_readableGuide_with_gap() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.leadingReadable, gap: 10)
		assertThat(view, isPinnedToReadableAnchor(.leading, gap: 10))
		assertThat(view, not(isPinned(.leading, gap: 10)))
	}

	func test_pin_trailing_with_readableGuide_with_gap() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.trailingReadable, gap: 10)
		assertThat(view, isPinnedToReadableAnchor(.trailing, gap: 10))
		assertThat(view, not(isPinned(.trailing, gap: 10)))
	}

	func test_pin_bottom_with_safeGuide_with_gap() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.bottomSafeArea, gap: 10)
		assertThat(view, isPinnedToSafeAreaAnchor(.bottom, gap: 10))
		assertThat(view, not(isPinned(.bottom, gap: 10)))
	}

	func test_pin_bottom_with_safeGuide_with_insets() {
		toView.addSubview(view)
		let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)

		// when
		view.layout.pin(.leadingSafeArea, .trailingSafeArea, .bottomSafeArea, .topSafeArea, insets: insets)

		// then
		assertThat(view, isPinnedToSafeAreaAnchor(.top, gap: 1))
		assertThat(view, isPinnedToSafeAreaAnchor(.bottom, gap: 3))
		assertThat(view, isPinnedToSafeAreaAnchor(.leading, gap: 2))
		assertThat(view, isPinnedToSafeAreaAnchor(.trailing, gap: 4))
	}


	func test_pin_to_first_baseline_top() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.firstBaseline, gap: 10)
		assertThat(view, isPinned(.firstBaseline, gap: 10))
	}

	func test_pin_to_last_baseline_bottom() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.lastBaseline, gap: 10)
		assertThat(view, isPinned(.lastBaseline, gap: 10))
	}

	func test_pin_to_last_baseline_bottom_with_gap_close_to() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.lastBaseline, gap: 11.111)
		assertThat(view, isPinned(.lastBaseline, gap: closeTo(11, 0.12)))
	}


	func test_pin_first_on_bottom_to_second() {
		let superview = UIView()
		let first = UIView()
		let second = UIView()
		superview.addSubview(first)
		superview.addSubview(second)

		first.layout.pin(.top, to: second)

		// then
		assertThat(first, isPinned(.top, to: second))
		assertThat(first, isPinned(first: .top, second: .bottom, to: second))
	}

	func test_pin_first_on_bottom_to_third() {
		let superview = UIView()
		let first = UIView()
		let second = UIView()
		let third = UIView()
		superview.addSubview(first)
		superview.addSubview(second)
		superview.addSubview(third)

		third.layout.pin(.top, to: first)

		// then
		assertThat(third, isPinned(.top, to: first))
		assertThat(third, isPinned(first: .top, second: .bottom, to: first))
	}

	func test_pin_to_top_guide() {
		let first = UIView()
		let viewController = UIViewController()
		viewController.loadView()
		viewController.view.addSubview(first)

		// when
		let layout = Layout()
		layout.pin(view: first, to:.top, withGuide: viewController.topLayoutGuide)

		// then
		assertThat(first, isPinned(.top, withGuide: viewController.topLayoutGuide))
	}

	func test_pin_to_bottom_guide() {
		let first = UIView()
		let second = UIView()
		let viewController = UIViewController()
		viewController.loadView()
		viewController.view.addSubview(first)
		first.addSubview(second)

		// when
		let layout = Layout()
		layout.pin(view: second, to:.bottom, withGuide: viewController.topLayoutGuide)

		// then
		assertThat(second, isPinned(.bottom, withGuide: viewController.topLayoutGuide))
	}


	func test_matcher_with_first_and_last() {
		toView.addSubview(view)

		// when
		pinLayout.pin(view:view, to:.lastBaseline, gap: 0)

		// then
		assertThat(view, isPinned(first: .bottom, second: .lastBaseline))
	}

	func test_pin_with_priority_and_relation() {
		toView.addSubview(view)

		// when
		view.layout.pin(.bottom, gap: 5, priority: .defaultLow, relatedBy: .greaterThanOrEqual)

		// then
		assertThat(view, isPinned(.bottom, gap: 5, priority: .defaultLow, relatedBy: .greaterThanOrEqual))
	}

}
