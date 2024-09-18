//
// Created by Rene Pirringer
// Copyright (c) 2018 Rene Pirringer. All rights reserved.
//




import Foundation
import XCTest
import SwiftHamcrest
import HamcrestAutolayoutMatchers


class ConstraintMatcherTest : XCTestCase {

	var first : UIView!
	var superview : UIView!

	override func setUp() {
		super.setUp()
		first = UIView()
		superview = UIView()
		superview.addSubview(first)
	}

	override func tearDown() {
		first = nil
		superview = nil
		super.tearDown()
	}

	func test_height_matcher() {
		// given
		first.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		
		// expect
		assertThat(first, hasHeight(of: 44))
	}

	func test_width_matcher() {
		// given
		first.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		// expect
		assertThat(first, hasWidth(of: 55))
	}

	func test_height_matcher_with_default_priority() {
		// given
		first.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		
		// expect
		assertThat(first, hasHeight(of: 44, withPriority: .required))
	}
	

	func test_width_matcher_with_default_priority() {
		// given
		first.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		// expect
		assertThat(first, hasWidth(of: 55, withPriority: .required))
	}


	func test_height_matcher_with_priority() {
		// given
		let constraint = first.heightAnchor.constraint(equalToConstant: 44.0)
		constraint.priority = .defaultLow
		constraint.isActive = true
		
		// expect
		assertThat(first, hasHeight(of: 44, withPriority: .defaultLow))
	}

}
