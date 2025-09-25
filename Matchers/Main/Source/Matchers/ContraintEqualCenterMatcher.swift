//
// Created by René Pirringer on 08.01.21.
// Copyright (c) 2021 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Hamcrest

@MainActor public func isEqualCenter<T: UIView>() -> Matcher<T> {
	return allOf(isEqualCenterX(), isEqualCenterY())
}

// MARK: - CenterX

@MainActor public func isEqualCenterX<T: UIView>() -> Matcher<T> {
	return hasEqualConstraint(.centerX)
}



@MainActor public func isEqualCenterX<T: UIView>(offset: CGFloat) -> Matcher<T> {
	return hasEqualConstraint(.centerX, constant: offset)
}

@MainActor public func isEqualCenterX<T: UIView>(with view: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerX, with: view, constant: offset)
}

// MARK: - Center Y

@MainActor public func isEqualCenterY<T: UIView>() -> Matcher<T> {
	return hasEqualConstraint(.centerY)
}


@MainActor public func isEqualCenterY<T: UIView>(offset: CGFloat) -> Matcher<T> {
	return hasEqualConstraint(.centerY, constant: offset)
}


@MainActor public func isEqualCenterY<T: UIView>(with view: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerY, with: view, constant: offset)
}


// MARK: - Horizontal Save Area


@MainActor public func isCenterX<T: UIView>(priority: UILayoutPriority = .required, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerX, constant: offset, priority: priority)
}

@MainActor public func isCenterX<T: UIView>(with other: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerX, with: other, constant: offset)
}

// MARK: - Vertical Save Area

@MainActor public func isCenterY<T: UIView>(priority: UILayoutPriority = .required, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerY, constant: offset, priority: priority)
}

@MainActor public func isCenterY<T: UIView>(with other: UIView, offset: CGFloat = 0) -> Matcher<T> {
	return hasEqualConstraint(.centerY, with: other, constant: offset)
}


// MARK: - vertical and horizontal

@MainActor public func isCenter<T: UIView>() -> Matcher<T> {
	return allOf(isCenterX(), isCenterY())
}


@MainActor public func isCenter<T: UIView>(with other: UIView) -> Matcher<T> {
	return allOf(isCenterX(with: other), isCenterY(with: other))
}

