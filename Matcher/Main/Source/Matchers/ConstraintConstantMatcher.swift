//
//  ConstraintConstantMatcher.swift
//
//  Created by Rene Pirringer
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import Hamcrest
import UIKit


private func hasMatchingConstantConstraint(_ view: UIView, attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, constant: CGFloat, withPriority priority: UILayoutPriority ) -> MatchResult {

	for constraint in view.constraints {
		if (constraint.firstAttribute == attribute &&
				constraint.relation == relation &&
				constraint.constant == constant &&
				constraint.priority == priority &&
				constraint.isActive) {

			return .match
		}
	}
	return .mismatch(nil)

}

public func hasConstantConstraint<T:UIView>(_ attribute: NSLayoutConstraint.Attribute, constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal, withPriority priority: UILayoutPriority = .required) -> Matcher<T> {
	return Matcher("view has contant value for \(descriptionOfAttribute(attribute)) of \(constant)") {
		(value: T) -> MatchResult in
		return hasMatchingConstantConstraint(value, attribute: attribute, relation:relation, constant: constant, withPriority: priority)
	}
}

private func hasConstraint(_ view: UIView, attribute: NSLayoutConstraint.Attribute, matcher: Matcher<CGFloat>) -> MatchResult {
	for constraint in view.constraints {
		if (constraint.firstAttribute == attribute) {
			if (matcher.matches(constraint.constant).boolValue) {
				return .match
			}
		}
	}
	return .mismatch(nil)
}

private func hasConstraint(_ view: UIView, attribute: NSLayoutConstraint.Attribute, matcher: Matcher<Double>) -> MatchResult {
	for constraint in view.constraints {
		if (constraint.firstAttribute == attribute) {
			if (matcher.matches(Double(constraint.constant)).boolValue) {
				return .match
			}
		}
	}
	return .mismatch(nil)
}


public func hasHeight<T:UIView>(_ matcher: Matcher<CGFloat>) -> Matcher<T> {
	return Matcher("view has constant value of \(matcher.description)") {
		(value: T) -> MatchResult in
		return hasConstraint(value, attribute: .height, matcher: matcher)
	}
}

public func hasHeight<T:UIView>(_ matcher: Matcher<Double>) -> Matcher<T> {
	return Matcher("view has constant value of \(matcher.description)") {
		(value: T) -> MatchResult in
		return hasConstraint(value, attribute: .height, matcher: matcher)
	}
}


public func hasWidth<T:UIView>(_ matcher: Matcher<CGFloat>) -> Matcher<T> {
	return Matcher("view has constant value of \(matcher.description)") {
		(value: T) -> MatchResult in
		return hasConstraint(value, attribute: .width, matcher: matcher)
	}
}

public func hasWidth<T:UIView>(_ matcher: Matcher<Double>) -> Matcher<T> {
	return Matcher("view has constant value of \(matcher.description)") {
		(value: T) -> MatchResult in
		return hasConstraint(value, attribute: .width, matcher: matcher)
	}
}

public func hasHeight<T:UIView>(of height: CGFloat, withPriority priority: UILayoutPriority = .required) -> Matcher<T> {
	return hasConstantConstraint(.height, constant: height, withPriority: priority)
}

public func hasWidth<T:UIView>(of width: CGFloat, withPriority priority: UILayoutPriority = .required) -> Matcher<T> {
	return hasConstantConstraint(.width, constant: width, withPriority: priority)
}

public func hasMinHeight<T:UIView>(of height: CGFloat) -> Matcher<T> {
	return hasConstantConstraint(.height, constant: height, relation: .greaterThanOrEqual)
}

public func hasMinWidth<T:UIView>(of width: CGFloat) -> Matcher<T> {
	return hasConstantConstraint(.width, constant: width, relation: .greaterThanOrEqual)
}

public func hasConstraint<T:UIView>(_ attribute: NSLayoutConstraint.Attribute) -> Matcher<T> {
	return Matcher("view has constraint with attribute \(attribute)") { (view: T) -> MatchResult in
		for constraint in view.constraints {
			if (constraint.firstAttribute == attribute &&
				constraint.isActive) {
				return .match
			}
		}
		return .mismatch(nil)
	}
}
