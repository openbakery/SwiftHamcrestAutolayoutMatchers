//
//  LayoutInCodeViewControllerTest.swift
//  Demo
//
//  Created by René Pirringer on 20.03.20.
//  Copyright © 2020 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class LayoutInCodeViewController: UIViewController {
	
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
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		bottomButton.translatesAutoresizingMaskIntoConstraints = false
		centerButton.translatesAutoresizingMaskIntoConstraints = false

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


		titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true

		subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
		subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true

		bottomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
		bottomButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true

		centerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		centerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true

	}
}
