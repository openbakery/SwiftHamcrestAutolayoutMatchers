//
// Created by René Pirringer.
// Copyright (c) 2022 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import Hamcrest
import HamcrestAutolayoutMatchers

@available(iOS 14, *)
class Contraint_Anchor_Matcher_Test: XCTestCase {


	func test_cell_separatorGuide() {
		let configuration = UIListContentConfiguration.subtitleCell()
		let cell = UICollectionViewListCell()
		cell.contentConfiguration = configuration

		let contentView = cell.contentView
		assertThat(cell.contentView, present())

		cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true

		// then
		assertThat(contentView, hasAnchor(.leading, cell.separatorLayoutGuide))
	}

	func test_cell_label_separatorGuide() {
		let configuration = UIListContentConfiguration.subtitleCell()
		let cell = UICollectionViewListCell()
		cell.contentConfiguration = configuration
		let label = UILabel()

		let contentView = cell.contentView
		assertThat(cell.contentView, present())
		contentView.addSubview(label)


		cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true

		// then
		assertThat(label, hasAnchor(.leading, cell.separatorLayoutGuide))
	}

}
