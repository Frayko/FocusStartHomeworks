//
//  ScreensFactory.swift
//  myCV
//
//  Created by Александр Фомин on 15.11.2021.
//

import Foundation
import UIKit

final class ScreensFactory {
	static let dataMapper = DataMapper()
	
	static func makeProfileScreen() -> ProfileTabVC {
		let controller = ProfileTabVC()
		dataMapper.setProfileTabViewData(controller)
		return controller
	}
	static func makeSkillsScreen() -> SkillsTabVC {
		let controller = SkillsTabVC()
		dataMapper.setSkillsTabViewData(controller)
		return controller
	}
	static func makeInterestsScreen() -> InterestsTabVC {
		let controller = InterestsTabVC()
		dataMapper.setInterestsTabViewData(controller)
		return controller
	}
}
