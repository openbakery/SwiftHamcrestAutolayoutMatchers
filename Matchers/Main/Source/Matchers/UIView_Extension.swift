//
//  UIView_Extension.swift
//  HamcrestAutolayoutMatchers
//
//  Created by René Pirringer on 30.04.26.
//  Copyright © 2026 Rene Pirringer. All rights reserved.
//

import UIKit

extension UIView {
	
	func guide(_ guide: Guide) -> UILayoutGuide? {
		switch guide {
		case .safeArea:
			return self.safeAreaLayoutGuide
		case .readable:
			return self.readableContentGuide
		case .keyboard:
			if #available(iOS 15, *) {
				return self.keyboardLayoutGuide
			} else {
				return nil
			}
		case .content:
			if let scrollView = self as? UIScrollView {
				return scrollView.contentLayoutGuide
			}
			return nil
		}
	}
}
