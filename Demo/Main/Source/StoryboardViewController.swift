//
//  StoryboardViewController.swift
//  Demo
//
//  Created by René Pirringer on 19.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import UIKit

class StoryboardViewController: UIViewController {

	@IBOutlet var titleLabel: UILabel?
	@IBOutlet var subtitleLabel: UILabel?
	@IBOutlet var bottomButton: UIButton?
	@IBOutlet var centerButton: UIButton?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		bottomButton?.addTarget(self, action: #selector(bottomButtonPressed), for: .touchUpInside)
		centerButton?.addTarget(self, action: #selector(centerButtonPressed), for: .touchUpInside)

	}
	
	@objc
	func bottomButtonPressed() {
		let viewController = LayoutInCodeViewController()
		self.navigationController?.pushViewController(viewController, animated:true)
	}
	
	@objc
	func centerButtonPressed() {
		let viewController = PinLayoutViewController()
		self.navigationController?.pushViewController(viewController, animated:true)
	}
    
}
