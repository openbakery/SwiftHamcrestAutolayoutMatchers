//
// Created by René Pirringer on 11.01.21.
// Copyright (c) 2021 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest
import PinLayout
@testable import HamcrestAutolayoutMatchers

class EqualWidth_Test : XCTestCase {

	var pinLayout: PinLayout!
	var superview : UIView!
	var first : UIView!
	var second : UIView!

	override func setUp() {
		super.setUp()
		pinLayout = PinLayout()
		superview = UIView()
		first = UIView()
		second = UIView()
		superview.addSubview(first)
		superview.addSubview(second)
	}

	override func tearDown() {
		pinLayout = nil
		superview = nil
		first = nil
		second = nil
		super.tearDown()
	}

	func test_has_same_width() {
		// when
		pinLayout.setEqualWidth(view: first, andView: second)

		// then
		assertThat(first, hasSameWidthAs(second))
	}

	func test_has_same_height() {
		// when
		pinLayout.setEqualHeight(view: first, andView: second)

		// then
		assertThat(first, hasSameHeightAs(second))
	}


	func test_has_same_width_with_multiplier() {
		// when
		pinLayout.setEqualWidth(view: first, andView: second, multiplier: 0.6)

		// then
		assertThat(first, hasSameWidthAs(second, multiplier: 0.6))
	}


	func test_has_same_height_with_multiplier() {
		// when
		pinLayout.setEqualHeight(view: first, andView: second, multiplier: 0.6)

		// then
		assertThat(first, hasSameHeightAs(second, multiplier: 0.6))
	}


}
