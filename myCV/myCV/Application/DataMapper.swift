//
//  DataMapper.swift
//  myCV
//
//  Created by Александр Фомин on 13.11.2021.
//

import Foundation

struct Profile {
	let name: String
	let surname: String
	let age: Int
	let description: String
	
	var fullName: String {
		self.name + " " + self.surname
	}
}

struct Language {
	let name: String
	let photoName: String
	let experience: String
}

struct Skills {
	let history: String
	let languages: [Language]
}

final class DataMapper {
	private let profileData: Profile
	private let skillsData: Skills
	
	init() {
		let descText = """
				ewqqwdqwd qwdewq wdq qdwqd wqd qwx dwqd qwd hjvgwqj dgvqwjd vqwjg dhvqjgdvqwgdvwqjg
			ewqdsad asd ad as das das
			qwe qds dqw dqwdwq
			ewqdqdwq
			"""
		
		profileData = Profile(name: "Test",
							  surname: "Test2",
							  age: 999,
							  description: descText)
		let langs = [Language(name: "C++",
							  photoName: "c++",
							  experience: "ddwqdqeqdwq"),
					 Language(name: "Java",
							  photoName: "java",
							  experience: "wqeqdwqn\n\newqewqeqwe\nqweqweq")
					 ]
		skillsData = Skills(history: "dwqdwqdqw\n\ndqwdq\newqdqweq\nweqwdqwd", languages: langs)
		
		
	}
	
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
}
