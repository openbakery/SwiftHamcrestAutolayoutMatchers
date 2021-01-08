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

private func matchesConstant(constraint: NSLayoutConstraint, constant: Float) -> MatchResult {
	
	if constraint.constant == CGFloat(constant) {
		return .match
	}
	return .mismatch("Constraint constant does not match. Expected constant of \(constant) but was \(constraint.constant)")
	/*
	if let matcher = matcher {
		if matcher.matches(Float(constraint.constant)).boolValue {
			return .match
		} else {
			return .mismatch("Constraint constant does not match: \(matcher.description)")
		}
	}
	return .match
*/
}

private func hasAnchorConstraint(for view: UIView,
																 baseView: UIView,
																 attribute: NSLayoutConstraint.Attribute,
																 guide: UILayoutGuide,
																 constant: Float) -> MatchResult {
	
	for constraint in baseView.constraints {
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



private func hasAnchorConstraint(for view: UIView, baseView: UIView, attribute: NSLayoutConstraint.Attribute, guide: UILayoutGuide, constant: CGFloat = 0) -> MatchResult {
	
	return hasAnchorConstraint(for: view, baseView: baseView, attribute: attribute, guide: guide, constant: Float(constant))
}

func hasSafeAreaAnchorConstraint(for view: UIView,
																				 baseView: UIView?,
																				 attribute: NSLayoutConstraint.Attribute,
																				 constant: Float = 0) -> MatchResult {
	if #available(iOS 11, *) {
		if let baseView = baseView {
			return hasAnchorConstraint(for: view, baseView: baseView, attribute: attribute, guide: baseView.safeAreaLayoutGuide, constant: constant)
		}
	}
	return .mismatch(nil)
}


private func hasReadableAnchorConstraint(for view: UIView, baseView: UIView?, attribute: NSLayoutConstraint.Attribute, constant: Float = 0) -> MatchResult {
	if #available(iOS 9, *) {
		if let baseView = baseView {
			return hasAnchorConstraint(for: view, baseView: baseView, attribute: attribute, guide: baseView.readableContentGuide, constant: constant)
		}
	}
	return .mismatch(nil)
}



public func isPinnedToSafeAreaAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, baseView: value.superview, attribute: attribute)
	}
}

public func isPinnedToSafeAreaAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute, gap: Float) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, baseView: value.superview, attribute: attribute, constant: gap)
	}
}


public func isPinnedToReadableAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasReadableAnchorConstraint(for: value, baseView: value.superview, attribute: attribute, constant: 0)
	}
}


public func isPinnedToReadableAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute, gap: Float) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasReadableAnchorConstraint(for: value, baseView: value.superview, attribute: attribute, constant: -gap)
	}
}
