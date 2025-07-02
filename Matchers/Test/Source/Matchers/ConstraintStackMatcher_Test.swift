//
//  ConstraintStackMatcher_Test.swift
//  HamcrestAutolayoutMatchersTest
//
//  Created by René Pirringer on 17.04.24.
//  Copyright © 2024 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Testing
import Hamcrest
import HamcrestSwiftTesting
import PinLayout
@testable import HamcrestAutolayoutMatchers

@MainActor 
class ConstraintStackMatcherTest {

	init() async throws {
		HamcrestSwiftTesting.enable()
	}


	@Test func matches_isStack_onTopOf_whtn_first_is_stacked_onTopOf_second() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)

		// when
		first.layout.stack(onTopOf: second)


		// then
		assertThat(first, isStacked(onTopOf: second))
	}


	@Test func matches_isStack_onTopOf_whtn_first_is_stacked_onTopOf_second_with_gap() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)

		// when
		first.layout.stack(onTopOf: second, gap: 12)


		// then
		assertThat(first, not(isStacked(onTopOf: second)))
		assertThat(first, isStacked(onTopOf: second, gap: 12))
	}


}
