//
//  UIColorMatcher.swift
//  DemoTests
//
//  Created by René Pirringer on 20.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//


import Foundation
import UIKit
import Hamcrest

func areEqualFloat(_ first: CGFloat, _ second: CGFloat) -> Bool {
	return Int(round(first * 255)) == Int(round(second * 255))
}

public func equalToColor<Color: UIColor>(_ given: UIColor) -> Matcher<Color> {
	return Matcher("is same color") {
		(value) -> MatchResult in

			var valueRed: CGFloat = 0
			var valueGreen: CGFloat = 0
			var valueBlue: CGFloat = 0
			var valueAlpha: CGFloat = 0
			var givenRed: CGFloat = 0
			var givenGreen: CGFloat = 0
			var givenBlue: CGFloat = 0
			var givenAlpha: CGFloat = 0

			value.getRed(&valueRed, green: &valueGreen, blue: &valueBlue, alpha: &valueAlpha);
			given.getRed(&givenRed, green: &givenGreen, blue: &givenBlue, alpha: &givenAlpha);

			if areEqualFloat(valueRed, givenRed) &&
							areEqualFloat(valueGreen, givenGreen) &&
							areEqualFloat(valueBlue, givenBlue) &&
							areEqualFloat(valueAlpha, givenAlpha) {
				return .match
			}

		return .mismatch("color \(rgbString(color:given)) is not equal to : \(rgbString(color:value))")

	}
}
	
func rgbString(color: UIColor) -> String {
	var red: CGFloat = 0
	var green: CGFloat = 0
	var blue: CGFloat = 0
	var alpha: CGFloat = 0
	color.getRed(&red, green: &green, blue: &blue, alpha: &alpha);
	
	var result = "UIColor(red: \(Int(red*255))"
	result += ", green: \(Int(green*255))"
	result += ", blue: \(Int(blue*255))"
	
	result += String(format:", alpha %.2f)", alpha)
	
	return result
	
}
