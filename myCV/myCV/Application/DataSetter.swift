//
//  DataMapper.swift
//  myCV
//
//  Created by Александр Фомин on 13.11.2021.
//

final class DataSetter {
	private lazy var profileData: Profile = {
		let description = """
			    Родился в городе Усть-Илимск.
			    В 16 лет понял, что не хочу обучаться в местном университете (он у нас всего 1 на минуточку :D) и к 18 годам переехал в Новосибирск, где поступил в НГТУ на программного инженера на контрактной основе. Чуть позже перевёлся на бюджет.
			"""
		
		let profile = Profile(photoName: "avatar",
							  name: "Александр",
							  surname: "Фомин",
							  age: 21,
							  description: description)
		return profile
	}()
	
	private lazy var skillsData: Skills = {
		let history = """
				Программированием я стал заниматься в 16 лет, сначала это была веб разработка, где выигрывал в месных конкурсах веб разработчиков моих лет, а потом на первых курсах университета начал изучать C/C++ и Java, полностью забросив веб.
				Сейчас я заканчиваю последний курс бакалавриата и в качестве дипломной работы хочу разработать приложение на iOS. Swift я изучаю буквально пару месяцев, но обучение идёт довольно легко, потому что многие вещи схожи с тем, что я делал ранее в других языках.
				От обучения ожидаю получение знаний различных методов разработки под Swift как графического интерфейсов, так и архитектурных решений. Буду рад стать частью Вашей команды!)
			"""
		
		let javaExp = "Разрабатывал приложение для симуляции плавающих рыбок с их временем жизни, различным поведением и возможностью сохранения местоположения всех рыбок в СУБД PostgreSQL / файл"
		
		let cPlusPlusExp = "На этом языке я в основном практиковал алгоритмы и структуры данных, работу с СУБД и параллельное программирование"
		
		let langs = [Language(name: "Java",
							  photoName: "java",
							  experience: javaExp),
					 Language(name: "C++",
							  photoName: "c++",
							  experience: cPlusPlusExp),
					 ]
		let skills = Skills(history: history,
							languages: langs)
		return skills
	}()
	
	private lazy var interestsData: Interests = {
		let info = """
				В свободное от учёбы время я предпочитаю проводить за компьютерными играми, просмотром фильмов/аниме, чтением технической литературы или манги, игрой в настольный теннис и посиделками с друзьями.
				Также мне очень нравится путешествовать. Чуть ниже прикладываю фотографии из некоторых поездок.
			"""
		
		let interests = Interests(info: info,
								  imageNames: ["photo-1",
											   "photo-2",
											   "photo-3",
											   "photo-4",
											   "photo-5",
											   "photo-6",
											   "photo-7"])
		return interests
	}()
}

extension DataSetter {
	func setProfileTabViewData(_ viewController: IProfileTabVC) {
		viewController.setPhoto(named: profileData.photoName)
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
