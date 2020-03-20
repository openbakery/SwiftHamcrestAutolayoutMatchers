//
//  TestNavigationController.swift
//  DemoTests
//
//  Created by René Pirringer on 20.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class TestNavigationController : UINavigationController {
	
	
	override func loadViewIfNeeded() {
		super.loadViewIfNeeded()
		self.viewControllers.first?.loadViewIfNeeded()
	}
	
	override func pushViewController(_ viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: false)
	}
	
}
