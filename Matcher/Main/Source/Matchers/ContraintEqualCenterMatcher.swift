//
// Created by René Pirringer on 08.01.21.
// Copyright (c) 2021 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Hamcrest

public func isEqualCenter<T: UIView>() -> Matcher<T> {
	return allOf(isEqualCenterX(), isEqualCenterY())
}

// MARK: - CenterX

public func isEqualCenterX<T: UIView>() -> Matcher<T> {
	return hasEqualConstraint(.centerX)
}



public func isEqualCenterX<T: UIView>(offset: CGFloat) -> Matcher<T> {
	return hasEqualConstraint(.centerX, withConstant: offset)
}

public func isEqualCenterX<T: UIView>(with view: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerX, with: view, constant: offset)
}

// MARK: - Center Y

public func isEqualCenterY<T: UIView>() -> Matcher<T> {
	return hasEqualConstraint(.centerY)
}


public func isEqualCenterY<T: UIView>(offset: CGFloat) -> Matcher<T> {
	return hasEqualConstraint(.centerY, withConstant: offset)
}


public func isEqualCenterY<T: UIView>(with view: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerY, with: view, constant: offset)
}


// MARK: - Horizontal Save Area


public func isCenterX<T: UIView>() -> Matcher<T> {
	return Matcher("view is safe area center x") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, attribute: .centerX)
	}
}

public func isCenterX<T: UIView>(with other: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return Matcher("view is safe area center x") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, with: other, attribute: .centerX, constant: -offset)
	}
}

// MARK: - Vertical Save Area

public func isCenterY<T: UIView>() -> Matcher<T> {
	return Matcher("view is safe area center y") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, attribute: .centerY)
	}
}

public func isCenterY<T: UIView>(with other: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return Matcher("view is safe area center y") {
		(value: T) -> MatchResult in
		return hasSafeAreaAnchorConstraint(for: value, with: other, attribute: .centerY, constant: -offset)
	}
}


// MARK: - vertical and horizontal

public func isCenter<T: UIView>() -> Matcher<T> {
	return allOf(isCenterX(), isCenterY())
}


public func isCenter<T: UIView>(with other: UIView) -> Matcher<T> {
	return allOf(isCenterX(with: other), isCenterY(with: other))
}

