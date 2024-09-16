//
//  Test.swift
//  HamcrestAutolayoutMatchers
//
//  Created by René Pirringer on 16.09.24.
//

import UIKit
import PinLayout
import Testing
import Hamcrest
import HamcrestSwiftTesting
import HamcrestAutolayoutMatchers

@MainActor
struct Test {

	let view = UIView()
	let toView = UIView()
	let pinLayout = Layout()


	@Test
	func test_pin_leading_with_readableGuide() {
		toView.addSubview(view)
		pinLayout.pin(view:view, to:.leadingReadable)

		#assertThat(view, isPinnedToReadableAnchor(.leading))
		#assertThat(view, not(isPinned(.leading)))
	}
}
