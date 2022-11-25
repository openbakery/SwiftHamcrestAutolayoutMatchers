//
// Created by Rene Pirringer
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import Hamcrest
import UIKit


private func findSuperView(_ first:UIView, _ second:UIView) -> UIView? {

	var view = first
	while let superview = view.superview {
		if (superview == second) {
			return superview
		}
		view = superview
	}
	return findSuperView(first, second.superview)
}

public func findSuperView(_ first:UIView?, _ second:UIView?) -> UIView? {
	if let f = first {
		if let s = second {
			return findSuperView(f, s)
		}
	}
	return nil
}


// determines the second attribute based on the first and the views involved
private func secondAttribute(first: AnyObject, second: AnyObject, superview: UIView, firstAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint.Attribute {
	if let firstView = first as? UIView {
		if (superview != firstView && superview != firstView.superview) {
			return inverseAttribute(firstAttribute)
		}
	}
	if (superview !== second) {
		return inverseAttribute(firstAttribute)
	}
	if (firstAttribute == .firstBaseline) {
		return .top
	}
	return firstAttribute
}

private func hasMatchingConstraint(_ view: UIView,
																	 to: AnyObject,
																	 attribute: NSLayoutConstraint.Attribute,
																	 gap gapMatcher: Matcher<Float>,
																	 priority: UILayoutPriority,
																	 relatedBy relation: NSLayoutConstraint.Relation = .equal) -> MatchResult {

	guard let commonSuperView = findSuperView(view, view.superview) else {
		return .mismatch("no common super view found")
	}

	var firstItem: UIView = view
	var secondItem: AnyObject = to

	var firstAttribute = attribute
	var secondAttribute = secondAttribute(first: firstItem, second: secondItem, superview: commonSuperView, firstAttribute: attribute)

	if (to is UILayoutSupport) {
		secondAttribute = inverseAttribute(attribute)
	}

	if (secondAttribute == .lastBaseline) {
		firstAttribute = .bottom
	}
	return hasMatchingConstraint(firstItem,
		to: secondItem,
		firstAttribute: firstAttribute,
		secondAttribute: secondAttribute,
		gap: gapMatcher,
		priority: priority)
}

private func hasMatchingConstraint(_ view: UIView,
																	 to: AnyObject,
																	 firstAttribute: NSLayoutConstraint.Attribute,
																	 secondAttribute: NSLayoutConstraint.Attribute,
																	 gap gapMatcher: Matcher<Float>,
																	 priority: UILayoutPriority,
																	 relatedBy relation: NSLayoutConstraint.Relation = .equal) -> MatchResult {

	guard let commonSuperView = findSuperView(view, view.superview) else {
		return .mismatch("no common super view found")
	}

	var firstItem: AnyObject = view
	var secondItem: AnyObject = to

	if (secondAttribute == .lastBaseline) {
		swap(&firstItem, &secondItem)
	}

	if (firstAttribute == secondAttribute && (firstAttribute == .bottom || firstAttribute == .right || firstAttribute == .trailing )) {
		swap(&firstItem, &secondItem)
	}

	for constraint in commonSuperView.constraints {

		if (constraint.firstAttribute == firstAttribute &&
			constraint.secondAttribute == secondAttribute &&
			constraint.firstItem === firstItem &&
			constraint.secondItem === secondItem &&
			constraint.relation == relation &&
			constraint.priority == priority &&
			constraint.isActive
			 ) {

			if gapMatcher.matches(Float(constraint.constant)).boolValue {
				return .match
			}

		}
	}
	return .mismatch("no matching constraint found")
}


public func isPinned<T:UIView>(first: NSLayoutConstraint.Attribute,
															 second: NSLayoutConstraint.Attribute,
															 to toView: UIView? = nil,
															 gap gapMatcher: Matcher<Float> = equalTo(0),
															 priority: UILayoutPriority = UILayoutPriority.required,
															 relatedBy relation: NSLayoutConstraint.Relation = .equal) -> Matcher<T> {
	return Matcher("view is pinned to first \(descriptionOfAttribute(first)) and second \(descriptionOfAttribute(second)) to its superview with gap:\(gapMatcher)") {
		(value: T) -> MatchResult in
		if let toViewUnwrapped = toView {
			return hasMatchingConstraint(value, to: toViewUnwrapped, firstAttribute: first, secondAttribute: second, gap: gapMatcher, priority: priority, relatedBy: relation)
		} else if let superview = value.superview {
			return hasMatchingConstraint(value, to: superview, firstAttribute: first, secondAttribute: second, gap: gapMatcher, priority: priority, relatedBy: relation)
		} else {
			return .mismatch("view was not add as subview")
		}
	}
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, toView: UIView?, gap gapMatcher: Matcher<Float>, priority: UILayoutPriority = UILayoutPriority.required, relatedBy relation: NSLayoutConstraint.Relation = .equal) -> Matcher<T> {
	return Matcher("view is pinned \(descriptionOfAttribute(attribute)) to its superview with gap:\(gapMatcher)") {
		(value: T) -> MatchResult in
		if let toViewUnwrapped = toView {
			return hasMatchingConstraint(value, to: toViewUnwrapped, attribute: attribute, gap: gapMatcher, priority: priority, relatedBy: relation)
		} else if let superview = value.superview {
			return hasMatchingConstraint(value, to: superview, attribute: attribute, gap: gapMatcher, priority: priority, relatedBy: relation)
		} else {
			return .mismatch("view was not add as subview")
		}
	}
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, toView: UIView?, gap: CGFloat, priority: UILayoutPriority = UILayoutPriority.required, relatedBy relation: NSLayoutConstraint.Relation = .equal) -> Matcher<T> {
	return isPinned(attribute, toView: toView, gap: closeTo(Float(gap), 0.001), priority: priority, relatedBy: relation)
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, toView: UIView?) -> Matcher<T> {
	return isPinned(attribute, toView: toView, gap: equalTo(0))
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return isPinned(attribute, toView: nil, gap: equalTo(0))
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, relatedBy relation: NSLayoutConstraint.Relation) -> Matcher<T> {
	return isPinned(attribute, toView: nil, gap: equalTo(0), relatedBy: relation)
}


public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, gap gapMatcher: Matcher<Float>, priority: UILayoutPriority = UILayoutPriority.required, relatedBy relation: NSLayoutConstraint.Relation = .equal) -> Matcher<T> {
return isPinned(attribute, toView: nil, gap: gapMatcher, priority: priority, relatedBy: relation)
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, gap: CGFloat, priority: UILayoutPriority = UILayoutPriority.required, relatedBy relation: NSLayoutConstraint.Relation = .equal) -> Matcher<T> {
	return isPinned(attribute, gap: closeTo(Float(gap), 0.001), priority: priority, relatedBy: relation)
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, withGuide guide: UILayoutSupport, priority: UILayoutPriority = UILayoutPriority.required) -> Matcher<T> {
	return isPinned(attribute, to: guide, priority: priority)
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, to: AnyObject, gap: CGFloat, priority: UILayoutPriority = UILayoutPriority.required) -> Matcher<T> {
	return isPinned(attribute, to: to, gap: closeTo(Float(gap), 0.001), priority: priority)
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, to: AnyObject, gap: Matcher<Float>, priority: UILayoutPriority = UILayoutPriority.required) -> Matcher<T> {

	return Matcher("view is pinned \(descriptionOfAttribute(attribute)) to its superview") {
		(value: T) -> MatchResult in
		return hasMatchingConstraint(value, to: to, attribute: attribute, gap: gap, priority: priority)
	}
}

public func isPinned<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, to: AnyObject, priority: UILayoutPriority = UILayoutPriority.required) -> Matcher<T> {
	return isPinned(attribute, to: to, gap: 0, priority: priority)
}


public func isPinnedToAllEdges<T:UIView>(gap: CGFloat = 0) -> Matcher<T> {
	return allOf(
			isPinned(.leading, gap: gap),
			isPinned(.trailing, gap: gap),
			isPinned(.top, gap: gap),
			isPinned(.bottom, gap: gap)
	)
}

public func descriptionOfAttribute(_ attribute:NSLayoutConstraint.Attribute) -> String {
	switch attribute {
	case .left:
		return "Left"
	case .right:
		return "Right"
	case .top:
		return "Top"
	case .bottom:
		return "Bottom"
	case .leading:
		return "Leading"
	case .trailing:
		return "Trailing"
	case .width:
		return "Width"
	case .height:
		return "Height"
	case .centerX:
		return "CenterX"
	case .centerY:
		return "CenterY"
	case .lastBaseline:
		return "Baseline"
	case .firstBaseline:
		return "FirstBaseline"
	case .leftMargin:
		return "LeftMargin"
	case .rightMargin:
		return "RightMargin"
	case .topMargin:
		return "TopMargin"
	case .bottomMargin:
		return "BottomMargin"
	case .leadingMargin:
		return "LeadingMargin"
	case .trailingMargin:
		return "TrailingMargin"
	case .centerXWithinMargins:
		return "CenterXWithinMargins"
	case .centerYWithinMargins:
		return "CenterYWithinMargins"
	case .notAnAttribute:
		return "NotAnAttribute"
	default:
		return "unknown"
	}
}

func inverseAttribute(_ attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint.Attribute {
	switch (attribute) {
	case .top:
		return .bottom;
	case .bottom:
		return .top;
	case .right:
		return .left;
	case .left:
		return .right;
	case .leading:
		return .trailing
	case .trailing:
		return .leading
	default:
		return attribute;
	}
}

func swap(_ first: inout Any, _ second: inout Any) {
	let tmp = first
	second = first
	first = tmp
}

