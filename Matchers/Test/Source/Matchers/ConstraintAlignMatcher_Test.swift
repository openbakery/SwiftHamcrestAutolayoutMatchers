//
// Created by Rene Pirringer on 09.05.18.
// Copyright (c) 2018 Rene Pirringer. All rights reserved.
//


import Foundation
import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers
import PinLayout

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


	func test_first_is_aligned_to_second_bottom_matcher() {
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



	func test_first_is_aligned_to_second_bottom_matcher_also_matches_when_reversed() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)

		// when

		first.bottomAnchor.constraint(equalTo: second.bottomAnchor).isActive = true

		// then
		assertThat(second, isAligned(with:first, to:.bottom))
	}



	func test_first_isAligned_matcher_reverse() {
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


	func test_view_is_aligned_with_superview_to_top() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)

		// when
		superview.topAnchor.constraint(equalTo: first.topAnchor).isActive = true

		// then
		assertThat(first, isAligned(with:superview, to:.top))
	}


	func test_view_is_aligned_to_top_to_its_superview() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)

		// when
		superview.topAnchor.constraint(equalTo: first.topAnchor).isActive = true

		// then
		assertThat(first, isAligned(to:.top))
	}

	func test_view_is_centerX() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)

		// when
		first.layout.centerX()

		// then
		assertThat(first, isCenterX())
	}

	func test_view_is_centerY() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)

		// when
		first.layout.centerY()

		// then
		assertThat(first, isCenterY())
	}

	func test_view_is_center() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)

		// when
		let pinLayout = Layout()
		pinLayout.center(view: first)

		// then
		assertThat(first, isCenter())
	}

	func test_view_is_center_with_other_view() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)

		// when
		let pinLayout = Layout()
		pinLayout.center(view: first, with: second)

		// then
		assertThat(first, isCenter(with: second))
	}

	func test_view_is_center_with_other_view_with_offset() {
		// given
		let first = UIView()
		let second = UIView()
		let superview = UIView()
		superview.addSubview(first)
		superview.addSubview(second)

		// when
		let pinLayout = Layout()
		pinLayout.centerX(view: first, with: second, offset: 20)
		pinLayout.centerY(view: first, with: second, offset: 120)

		// then
		assertThat(first, isCenterX(with: second, offset: 20))
		assertThat(first, isCenterY(with: second, offset: 120))
	}

	
	func test_view_is_center_with_offset() {
		// given
		let first = UIView()
		let superview = UIView()
		superview.addSubview(first)

		// when
		first.layout
			.centerX(offset: 10)
			.centerY(offset: 20)

		// then
		assertThat(first, isCenterX(offset: 10))
		assertThat(first, isCenterY(offset: 20))
	}

}
