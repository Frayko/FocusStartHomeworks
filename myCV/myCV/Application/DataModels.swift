//
//  DataModels.swift
//  myCV
//
//  Created by Александр Фомин on 16.11.2021.
//

import Foundation

struct Profile {
	let photoName: String
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

struct Interests {
	let info: String
	let imageNames: [String]
}
