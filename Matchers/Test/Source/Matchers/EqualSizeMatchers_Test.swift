//
//  EqualSizeMatchers_Test.swift
//  HamcrestAutolayoutMatchersTest
//
//  Created by René Pirringer on 02.07.25.
//  Copyright © 2025 Rene Pirringer. All rights reserved.
//

import Foundation
import Testing
import Hamcrest
import HamcrestSwiftTesting
import PinLayout
import UIKit
@testable import HamcrestAutolayoutMatchers

@MainActor
class EqualSizeMatchers_Test {

	init() async throws {
		HamcrestSwiftTesting.enable()
		superview =  UIView()
		child = UIView()
		superview.addSubview(child)
	}

	let superview: UIView
	let child: UIView

	@Test
	func same_width() {
		// when
		child.layout.equalWidth(with: superview)

		// then
		assertThat(child, hasSameWidth(superview))
	}

	@Test
	func same_width_with_priority() {
		// when
		child.layout.equalWidth(with: superview, priority: .defaultLow)

		// then
		assertThat(child, hasSameWidth(superview, priority: .defaultLow))
	}

	@Test
	func same_height() {
		// when
		child.layout.equalHeight(with: superview)

		// then
		assertThat(child, hasSameHeight(superview))
	}

	@Test
	func same_height_with_priority() {
		// when
		child.layout.equalHeight(with: superview, priority: .defaultHigh)

		// then
		assertThat(child, hasSameHeight(superview, priority: .defaultHigh))
	}

	@Test
	func same_size_priority() {
		// when
		child.layout.equalSize(with: superview, priority: .defaultHigh)

		// then
		assertThat(child, hasSameHeight(superview, priority: .defaultHigh))
		assertThat(child, hasSameWidth(superview, priority: .defaultHigh))
	}
}

