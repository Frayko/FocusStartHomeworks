//
//  DataMapper.swift
//  myCV
//
//  Created by Александр Фомин on 13.11.2021.
//

import Foundation

final class DataMapper {
	private lazy var profileData: Profile = {
		let description = """
				ewqqwdqwd qwdewq wdq qdwqd wqd qwx dwqd qwd hjvgwqj dgvqwjd vqwjg dhvqjgdvqwgdvwqjg
			ewqdsad asd ad as das das
			qwe qds dqw dqwdwq
			ewqdqdwq
			"""
		
		let profile = Profile(name: "Александр",
							  surname: "Фомин",
							  age: 21,
							  description: description)
		return profile
	}()
	
	private lazy var skillsData: Skills = {
		let langs = [Language(name: "C++",
							  photoName: "c++",
							  experience: "ddwqdqeqdwq"),
					 Language(name: "Java",
							  photoName: "java",
							  experience: "wqeqdwqn\n\newqewqeqwe\nqweqweq")
					 ]
		let skills = Skills(history: "dwqdwqdqw\n\ndqwdq\newqdqweq\nweqwdqwd", languages: langs)
		return skills
	}()
	
	private lazy var interestsData: Interests = {
		let interests = Interests(info: "dsadsqwdqdqdqwwqdq\n\n\n\n\nweqeqwdwqdwq",
								  imageNames: ["java", "c++"])
		return interests
	}()
}

extension DataMapper {
	func setProfileTabViewData(_ viewController: IProfileTabVC) {
		viewController.setFullName(profileData.fullName)
		viewController.setAge(profileData.age)
		viewController.setDescription(profileData.description)
	}
	
	func setSkillsTabViewData(_ viewController: ISkillsTabVC) {
		viewController.setHistory(skillsData.history)
		for i in 0 ..< skillsData.languages.count {
			viewController.addStatistic(languageName: skillsData.languages[i].name,
										languagePhotoName: skillsData.languages[i].photoName,
										experience: skillsData.languages[i].experience)
		}
	}
	
	func setInterestsTabViewData(_ viewController: IInterestsTabVC) {
		viewController.setInfo(interestsData.info)
		viewController.setImages(items: interestsData.imageNames)
	}
}
