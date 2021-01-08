//
// Created by René Pirringer on 08.01.21.
// Copyright (c) 2021 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Hamcrest

public func isEqualCenter<T: UIView>() -> Matcher<T> {
	return allOf(isEqualHorizontalCenter(), isEqualVerticalCenter())
}

// MARK: - Horizontal

public func isEqualHorizontalCenter<T: UIView>() -> Matcher<T> {
	return hasEqualConstraint(.centerX)
}



public func isEqualHorizontalCenter<T: UIView>(offset: Float) -> Matcher<T> {
	return hasEqualConstraint(.centerX, withConstant: offset)
}

public func isEqualHorizontalCenter<T: UIView>(with view: UIView, offset: Float = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerX, with: view, constant: offset)
}

// MARK: - Vertical

public func isEqualVerticalCenter<T: UIView>() -> Matcher<T> {
	return hasEqualConstraint(.centerY)
}


public func isEqualVerticalCenter<T: UIView>(offset: Float) -> Matcher<T> {
	return hasEqualConstraint(.centerY, withConstant: offset)
}


public func isEqualVerticalCenter<T: UIView>(with view: UIView, offset: Float = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerY, with: view, constant: offset)
}


// MARK: - Horizontal Save Area


public func isCenterX<T: UIView>() -> Matcher<T> {
	return Matcher("view is safe area center x") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, baseView: value.superview, attribute: .centerX)
	}
}


// MARK: - Vertical Save Area

public func isCenterY<T: UIView>() -> Matcher<T> {
	return Matcher("view is safe area center x") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, baseView: value.superview, attribute: .centerY)
	}
}

public func isCenterSafeArea<T: UIView>() -> Matcher<T> {
	return allOf(isCenterX(), isCenterY())

}
