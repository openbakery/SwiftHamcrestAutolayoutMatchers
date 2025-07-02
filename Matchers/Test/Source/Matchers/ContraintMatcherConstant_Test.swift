//
// Created by René Pirringer.
// Copyright (c) 2022 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Testing
import PinLayout
import Hamcrest
import HamcrestSwiftTesting
import HamcrestAutolayoutMatchers

@MainActor
class ContraintMatcherConstant_Test {

	init() async throws {
		HamcrestSwiftTesting.enable()
	}


	@Test func has_height() {
		let layout = Layout()
		let view = UIView()

		// when
		layout.setHeight(of: view, to: 100)

		// then
		assertThat(view, hasHeight(of: 100))
	}

	@Test func has_height_constraint() {
		let layout = Layout()
		let view = UIView()

		// when
		layout.setHeight(of: view, to: 100)

		// then
		assertThat(view, hasConstraint(.height))
	}

	@Test func has_not_height_constraint() {
		let layout = Layout()
		let view = UIView()

		// when
		layout.setWidth(of: view, to: 100)

		// then
		assertThat(view, not(hasConstraint(.height)))
	}
}
