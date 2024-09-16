//
//  ConstraintStackMatcher.swift
//  HamcrestAutolayoutMatchersTest
//
//  Created by René Pirringer on 17.04.24.
//  Copyright © 2024 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Hamcrest


@MainActor private func hasMatchingStackConstraint(
		for view: UIView,
		with otherView: UIView,
		firstAttribute: NSLayoutConstraint.Attribute,
		secondAttribute: NSLayoutConstraint.Attribute,
		gap: CGFloat,
		relatedBy relation: NSLayoutConstraint.Relation = .equal) -> MatchResult {

	if let commonSuperView = findSuperView(view, otherView) {

		for constraint in commonSuperView.constraints {

			if (constraint.firstAttribute == firstAttribute &&
					constraint.secondAttribute == secondAttribute &&
					constraint.relation == relation &&
					constraint.constant == CGFloat(gap) &&
					constraint.isActive
				 ) {

				if constraint.firstItem === view && constraint.secondItem === otherView {
					return .match
				}
				if constraint.firstItem === otherView && constraint.secondItem === view {
					return .match
				}
			}

		}
	}
	return .mismatch(nil)
}


@MainActor public func isStacked<T: UIView>(onTopOf view: UIView, gap: CGFloat = 0) -> Matcher<T> {
	return Matcher("view is stack onTop of \(view)") { (value: T) -> MatchResult in
		return hasMatchingStackConstraint(for: value, with: view, firstAttribute: .bottom, secondAttribute: .top, gap: -gap)

	}
}
