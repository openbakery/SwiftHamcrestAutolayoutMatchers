//
// Created by René Pirringer.
// Copyright (c) 2022 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import Hamcrest
import HamcrestAutolayoutMatchers
import HamcrestSwiftTesting
import Testing

@MainActor
struct Contraint_Anchor_Matcher_Test {


	@Test func cell_separatorGuide() {
		let configuration = UIListContentConfiguration.subtitleCell()
		let cell = UICollectionViewListCell()
		cell.contentConfiguration = configuration

		let contentView = cell.contentView
		#assertThat(cell.contentView, present())

		cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true

		// then
		#assertThat(contentView, hasAnchor(.leading, cell.separatorLayoutGuide))
	}

	@Test func cell_label_separatorGuide() {
		let configuration = UIListContentConfiguration.subtitleCell()
		let cell = UICollectionViewListCell()
		cell.contentConfiguration = configuration
		let label = UILabel()

		let contentView = cell.contentView
		#assertThat(cell.contentView, present())
		contentView.addSubview(label)


		cell.separatorLayoutGuide.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true

		// then
		#assertThat(label, hasAnchor(.leading, cell.separatorLayoutGuide))
	}

}
