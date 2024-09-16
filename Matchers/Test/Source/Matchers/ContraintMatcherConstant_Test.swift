//
// Created by René Pirringer.
// Copyright (c) 2022 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import PinLayout
import Hamcrest
import HamcrestAutolayoutMatchers

@MainActor
class ContraintMatcherConstant_Test: XCTestCase {


	func test_has_height() {
		let layout = Layout()
		let view = UIView()

		// when
		layout.setHeight(of: view, to: 100)

		// then
		assertThat(view, hasHeight(of: 100))
	}

	func test_has_height_constraint() {
		let layout = Layout()
		let view = UIView()

		// when
		layout.setHeight(of: view, to: 100)

		// then
		assertThat(view, hasConstraint(.height))
	}

	func test_has_not_height_constraint() {
		let layout = Layout()
		let view = UIView()

		// when
		layout.setWidth(of: view, to: 100)

		// then
		assertThat(view, not(hasConstraint(.height)))
	}
}
