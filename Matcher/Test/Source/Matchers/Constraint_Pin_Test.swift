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
}
