//
// Created by Rene Pirringer
// Copyright (c) 2018 Rene Pirringer. All rights reserved.
//




import Foundation
import UIKit
import Hamcrest
import HamcrestAutolayoutMatchers
import HamcrestSwiftTesting
import Testing

@MainActor
struct ConstraintMatcherTest {

	let first : UIView
	let superview : UIView

	init() {
		HamcrestSwiftTesting.enable()
		first = UIView()
		superview = UIView()
		superview.addSubview(first)
	}


	@Test func height_matcher() {
		// given
		first.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		
		// expect
		assertThat(first, hasHeight(of: 44))
	}

	@Test func width_matcher() {
		// given
		first.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		// expect
		assertThat(first, hasWidth(of: 55))
	}

	@Test func height_matcher_with_default_priority() {
		// given
		first.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
		
		// expect
		assertThat(first, hasHeight(of: 44, withPriority: .required))
	}
	

	@Test func width_matcher_with_default_priority() {
		// given
		first.widthAnchor.constraint(equalToConstant: 55.0).isActive = true
		
		// expect
		assertThat(first, hasWidth(of: 55, withPriority: .required))
	}


	@Test func height_matcher_with_priority() {
		// given
		let constraint = first.heightAnchor.constraint(equalToConstant: 44.0)
		constraint.priority = .defaultLow
		constraint.isActive = true
		
		// expect
		assertThat(first, hasHeight(of: 44, withPriority: .defaultLow))
	}

}
