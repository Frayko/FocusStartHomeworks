//
//  ScreensFactory.swift
//  myCV
//
//  Created by Александр Фомин on 15.11.2021.
//

enum ScreensFactory {
	static let dataSetter = DataSetter()
	
	static func makeProfileScreen() -> IProfileTabVC {
		let controller: IProfileTabVC = ProfileTabVC()
		dataSetter.setProfileTabViewData(controller)
		return controller
	}
	
	static func makeSkillsScreen() -> ISkillsTabVC {
		let controller: ISkillsTabVC = SkillsTabVC()
		dataSetter.setSkillsTabViewData(controller)
		return controller
	}
	
	static func makeInterestsScreen() -> IInterestsTabVC {
		let controller: IInterestsTabVC = InterestsTabVC()
		dataSetter.setInterestsTabViewData(controller)
		return controller
	}
}
