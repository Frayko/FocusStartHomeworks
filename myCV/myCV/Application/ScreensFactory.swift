//
//  ScreensFactory.swift
//  myCV
//
//  Created by Александр Фомин on 15.11.2021.
//

import Foundation
import UIKit

final class ScreensFactory {
	static func makeProfileScreen() -> ProfileTabVC {
		return ProfileTabVC()
	}
	static func makeSkillsScreen() -> SkillsTabVC {
		return SkillsTabVC()
	}
	static func makeInterestsScreen() -> InterestsTabVC {
		return InterestsTabVC()
	}
}
