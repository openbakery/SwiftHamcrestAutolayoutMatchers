//
// Created by Rene Pirringer on 09.05.18.
// Copyright (c) 2018 Rene Pirringer. All rights reserved.
//


import Foundation
import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers

class ConstraintAlignMatcherTest : XCTestCase {

	func test_isPinned_matcher() {
		// given
		let view = UIView()
		let superview = UIView()
		superview.addSubview(view)
		
		// when
		superview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
		// then
		assertThat(view, isPinned(.bottom))
	}


	func test_isAligned_matcher() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)
		
		// when
		
		first.bottomAnchor.constraint(equalTo: second.bottomAnchor).isActive = true
		
		// then
		assertThat(first, isAligned(with:second, to:.bottom))
	}
	
	


	func test_isAligned_matcher_reverse() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)
		
		// when
		second.bottomAnchor.constraint(equalTo: first.bottomAnchor).isActive = true
		
		// then
		assertThat(second, isAligned(with:first, to:.bottom))
	}


	func test_isAligned_matcher_with_gap() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)
		
		// when
		first.bottomAnchor.constraint(equalTo: second.bottomAnchor, constant: 10.0).isActive = true
		
		// then
		assertThat(first, isAligned(with:second, to:.bottom, gap: 10))
	}

	
	func test_isAligned_should_not_pass_for_child_views() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)
		
		// when
		superview.bottomAnchor.constraint(equalTo: first.bottomAnchor).isActive = true
		
		// then
		assertThat(superview, not(isAligned(with:first, to:.bottom)))
	}

}
