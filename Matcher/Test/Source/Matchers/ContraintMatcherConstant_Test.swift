//
// Created by René Pirringer.
// Copyright (c) 2022 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import PinLayout
import Hamcrest
import HamcrestAutolayoutMatchers

class ContraintMatcherConstant_Test: XCTestCase {

	var layout: Layout!

	override func setUp() {
		super.setUp()
		layout = Layout()
	}

	override func tearDown() {
		layout = nil
		super.tearDown()
	}

	func test_has_height() {
		let view = UIView()

		// when
		layout.setHeight(of: view, to: 100)

		// then
		assertThat(view, hasHeight(of: 100))
	}

	func test_has_height_constraint() {
		let view = UIView()

		// when
		layout.setHeight(of: view, to: 100)

		// then
		assertThat(view, hasConstraint(.height))
	}

	func test_has_not_height_constraint() {
		let view = UIView()

		// when
		layout.setWidth(of: view, to: 100)

		// then
		assertThat(view, not(hasConstraint(.height)))
	}
}
