//
// Created by René Pirringer
//

import Foundation
import Hamcrest
import UIKit


func hasAttribute(constraint: NSLayoutConstraint, attribute: NSLayoutConstraint.Attribute) -> Bool {
	if (constraint.firstAttribute != attribute) {
		return false
	}
	if (constraint.secondAttribute != attribute) {
		return false
	}
	if (constraint.multiplier != 1.0 ) {
		return false
	}
	return constraint.isActive
	
}

private func matchesConstant(constraint: NSLayoutConstraint, constant: CGFloat) -> MatchResult {
	
	if constraint.constant == constant {
		return .match
	}
	return .mismatch("Constraint constant does not match. Expected constant of \(constant) but was \(constraint.constant)")

}

private func hasAnchorConstraint(for view: UIView,
																 attribute: NSLayoutConstraint.Attribute,
																 guide: UILayoutGuide,
																 constant: CGFloat) -> MatchResult {

	guard let superview = view.superview else {
		return .mismatch(nil)
	}
	
	
	for constraint in superview.constraints {
		if let guideItem = constraint.firstItem as? UILayoutGuide {
			if hasAttribute(constraint: constraint, attribute: attribute) &&
			constraint.secondItem === view &&
			guideItem == guide {
				return matchesConstant(constraint: constraint, constant: constant)
			}
		}

		// see if the the first attribue and second attribute is swapped
		if let guideItem = constraint.secondItem as? UILayoutGuide {
			if hasAttribute(constraint: constraint, attribute: attribute) &&
			constraint.secondItem === guideItem &&
			guideItem == guide {
				return matchesConstant(constraint: constraint, constant: -constant)
			}
		}
	}
	return .mismatch(nil)
}



func hasSafeAreaAnchorConstraint(for view: UIView,
																 with other: UIView? = nil,
																				 attribute: NSLayoutConstraint.Attribute,
																				 constant: CGFloat = 0) -> MatchResult {
	if #available(iOS 11, *) {
		if let superview = view.superview {
			let guide: UILayoutGuide
			if let otherGuide = other?.safeAreaLayoutGuide {
				guide = otherGuide
			} else {
				guide = superview.safeAreaLayoutGuide
			}

			return hasAnchorConstraint(for: view, attribute: attribute, guide: guide, constant: constant)
		}
	}
	return .mismatch(nil)
}


private func hasReadableAnchorConstraint(for view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> MatchResult {
	if #available(iOS 9, *) {
		if let baseView = view.superview {
			return hasAnchorConstraint(for: view, attribute: attribute, guide: baseView.readableContentGuide, constant: constant)
		}
	}
	return .mismatch(nil)
}


public func isPinnedToSafeAreaAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, attribute: attribute)
	}
}

public func isPinnedToSafeAreaAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute, gap: CGFloat) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, attribute: attribute, constant: gap)
	}
}


public func isPinnedToReadableAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasReadableAnchorConstraint(for: value, attribute: attribute, constant: 0)
	}
}


public func isPinnedToReadableAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute, gap: CGFloat) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasReadableAnchorConstraint(for: value, attribute: attribute, constant: -gap)
	}
}
