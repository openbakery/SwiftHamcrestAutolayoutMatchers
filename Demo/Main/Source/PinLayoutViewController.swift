//
//  PinLayoutViewController.swift
//  Demo
//
//  Created by René Pirringer on 20.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import PinLayout

class PinLayoutViewController: UIViewController {
	
	let titleLabel = UILabel()
	let subtitleLabel = UILabel()
	let bottomButton = UIButton()
	let centerButton = UIButton()

	override func loadView() {
		super.loadView()
		if #available(iOS 13, *) {
			self.view.backgroundColor = .systemBackground
		} else {
			self.view.backgroundColor = .white
		}

		titleLabel.text = "Title"
		subtitleLabel.text = "SubTitle"
		bottomButton.setTitle("Bottom Button", for: .normal)
		centerButton.setTitle("Center Button", for: .normal)
		
		bottomButton.backgroundColor = .red
		centerButton.backgroundColor = .green

		
		self.view.addSubview(titleLabel)
		self.view.addSubview(subtitleLabel)
		self.view.addSubview(bottomButton)
		self.view.addSubview(centerButton)

		let pinLayout = PinLayout()

		pinLayout.horizontalCenter(view: titleLabel)
		pinLayout.pin(view: titleLabel, to: .topSafeArea)
		
		pinLayout.pin(view: subtitleLabel, to: .leading, gap: 40)
		pinLayout.pin(view: subtitleLabel, to: .top, of: titleLabel, gap: 20)
		
		pinLayout.pin(view: bottomButton, to: .bottomSafeArea, gap: -40)
		pinLayout.pin(view: bottomButton, to: .trailingSafeArea, gap: -40)

		pinLayout.horizontalCenter(view: centerButton)
		pinLayout.verticalCenter(view: centerButton, offset: 40)

		
	}
}
