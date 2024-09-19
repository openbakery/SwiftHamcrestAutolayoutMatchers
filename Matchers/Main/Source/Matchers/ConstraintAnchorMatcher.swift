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

private func matchesConstant(constraint: NSLayoutConstraint, constant: CGFloat, priority: UILayoutPriority) -> MatchResult {

	if constraint.constant == constant &&
			constraint.priority == priority {
		return .match
	}
	return .mismatch("Constraint constant does not match. Expected constant of \(constant) but was \(constraint.constant)")

}

private func hasAnchorConstraint(for view: UIView,
																 attribute: NSLayoutConstraint.Attribute,
																 guide: UILayoutGuide,
																 constant: CGFloat,
																 priority: UILayoutPriority = .required) -> MatchResult {


	guard let superview = view.superview else {
		return .mismatch(nil)
	}

	return hasAnchorConstraint(for: view, superview: superview, attribute:attribute, guide: guide, constant: constant, priority: priority)

}

private func hasAnchorConstraint(for view: UIView,
																 superview: UIView,
																 attribute: NSLayoutConstraint.Attribute,
																 guide: UILayoutGuide,
																 constant: CGFloat,
																 priority: UILayoutPriority = .required) -> MatchResult {

	for constraint in superview.constraints {
		if let guideItem = constraint.firstItem as? UILayoutGuide {
			if hasAttribute(constraint: constraint, attribute: attribute) &&
			constraint.secondItem === view &&
			guideItem == guide {
				return matchesConstant(constraint: constraint, constant: constant, priority: priority)
			}
		}

		// see if the the first attribute and second attribute is swapped
		if let guideItem = constraint.secondItem as? UILayoutGuide {
			if hasAttribute(constraint: constraint, attribute: attribute) &&
			constraint.firstItem === view &&
			guideItem == guide {
				return matchesConstant(constraint: constraint, constant: -constant, priority: priority)
			}
		}
	}

	// the constraint can also be set at the superview of the superview, so lets check
	if let superview = superview.superview {
		return hasAnchorConstraint(for: view, superview: superview, attribute: attribute, guide: guide, constant: constant, priority: priority)
	}
	return .mismatch(nil)
}

private func hasAnchorConstraint(superview: UIView,
																 firstGuide: UILayoutGuide,
																 secondGuide: UILayoutGuide,
																 attribute: NSLayoutConstraint.Attribute,
																 constant: CGFloat,
																 priority: UILayoutPriority = .required) -> MatchResult {

	for constraint in superview.constraints {
		if constraint.firstItem === firstGuide &&
				 constraint.secondItem === secondGuide &&
				 hasAttribute(constraint: constraint, attribute: attribute) {
			return matchesConstant(constraint: constraint, constant: constant, priority: priority)
		}

		// see if the the first attribute and second attribute is swapped
		if constraint.firstItem === secondGuide &&
				 constraint.secondItem === firstGuide &&
				 hasAttribute(constraint: constraint, attribute: attribute) {
			return matchesConstant(constraint: constraint, constant: constant, priority: priority)
		}

	}

	return .mismatch(nil)
}

func hasSafeAreaGuideToViewConstraint(for view: UIView,
																			with other: UIView? = nil,
																			attribute: NSLayoutConstraint.Attribute,
																			constant: CGFloat = 0,
																			priority: UILayoutPriority = .required) -> MatchResult {
	if #available(iOS 11, *) {
		if let superview = view.superview {
			let guide: UILayoutGuide
			if let otherGuide = other?.safeAreaLayoutGuide {
				guide = otherGuide
			} else {
				guide = superview.safeAreaLayoutGuide
			}

			return hasAnchorConstraint(for: view, attribute: attribute, guide: guide, constant: constant, priority: priority)
		}
	}
	return .mismatch(nil)
}

func hasSafeAreaGuideToGuideConstraint(for view: UIView,
																			 with other: UIView? = nil,
																			 attribute: NSLayoutConstraint.Attribute,
																			 constant: CGFloat = 0,
																			 priority: UILayoutPriority = .required) -> MatchResult {
	if #available(iOS 11, *) {
		if let superview = view.superview {
			let secondGuide: UILayoutGuide
			if let otherGuide = other?.safeAreaLayoutGuide {
				secondGuide = otherGuide
			} else {
				secondGuide = superview.safeAreaLayoutGuide
			}

			return hasAnchorConstraint(superview: superview, firstGuide: view.safeAreaLayoutGuide, secondGuide: secondGuide, attribute: attribute, constant: constant, priority: priority)
		}
	}
	return .mismatch(nil)
}


private func hasReadableAnchorConstraint(for view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> MatchResult {
	if #available(iOS 9, *) {
		if let baseView = view.superview {
			let constantValue: CGFloat
			switch attribute {
			case .trailing:
				constantValue = -constant
			default:
				constantValue = constant
			}
			return hasAnchorConstraint(for: view, attribute: attribute, guide: baseView.readableContentGuide, constant: constantValue)
		}
	}
	return .mismatch(nil)
}

private func hasAnchorConstraint(for view: UIView, attribute: NSLayoutConstraint.Attribute, guide: UILayoutGuide) -> MatchResult {
	if #available(iOS 9, *) {
		return hasAnchorConstraint(for: view, attribute: attribute, guide: guide, constant: 0)
	}
	return .mismatch(nil)
}


public func isPinnedToSafeAreaAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		return hasSafeAreaGuideToViewConstraint(for: value, attribute: attribute)
	}
}

public func isPinnedToSafeAreaAnchor<T: UIView>(_ attribute: NSLayoutConstraint.Attribute, gap: CGFloat) -> Matcher<T> {
	return Matcher("view has \(attribute) anchor for safe area") {
		(value: T) -> MatchResult in
		let gapValue:  CGFloat
		if attribute == .top || attribute == .leading {
			gapValue = -gap
		} else {
			gapValue = gap
		}
		return hasSafeAreaGuideToViewConstraint(for: value, attribute: attribute, constant: gapValue)
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


public func hasAnchor<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, _ guide : UILayoutGuide) -> Matcher<T> {
	return Matcher("view is has anchor \(attribute))") {
		(value: T) -> MatchResult in

		return hasAnchorConstraint(for: value, attribute: attribute, guide: guide)
	}
}
