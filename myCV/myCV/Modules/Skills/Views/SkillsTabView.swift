//
//  SkillsTabView.swift
//  myCV
//
//  Created by Александр Фомин on 12.11.2021.
//

import UIKit

protocol ISkillsTabView: UIView {
	func didLoad()
	func setHistory(_ text: String)
	func addStatistic(_ languageName: String,
					  _ languagePhotoName: String,
					  _ languageExperience: String)
}

final class SkillsTabView: UIView {
	private let screenSize = UIScreen.main.bounds
	private var statsStackView = [UIStackView]()
	
	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.layer.masksToBounds = true
		return scrollView
	}()
	
	private lazy var historyText: UITextView = {
		let textView = UITextView()
		textView.backgroundColor = UIColor.systemBackground
		textView.font = UIFont.systemFont(ofSize: 16)
		textView.textAlignment = .left
		textView.textColor = UIColor.label
		textView.isEditable = false
		textView.isSelectable = true
		textView.isScrollEnabled = false
		textView.layer.cornerRadius = SkillsTabLayout.textCornerRadius
		textView.backgroundColor = .lightText
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}()
	
	private func addStatItem(_ languageName: String,
							 _ languagePhotoName: String,
							 _ languageExperience: String) {
		let label = buildStatNameLanguage(languageName)
		let imageView = buildStatImageView(languagePhotoName)
		let textView = buildStatTextExperience(languageExperience)
		
		let vStack = UIStackView(arrangedSubviews: [imageView, label, textView])
		vStack.axis = .vertical
		vStack.spacing = SkillsTabLayout.statStackViewSpacing
		vStack.translatesAutoresizingMaskIntoConstraints = false
		vStack.alignment = .center
		
		self.statsStackView.append(vStack)
	}
	
	private func buildStatImageView(_ photoName: String) -> UIImageView {
		let image = UIImage(named: photoName)
		let imageView = UIImageView()
		imageView.image = image
		imageView.backgroundColor = .cyan
		imageView.layer.cornerRadius = SkillsTabLayout.imageViewCornerRadius
		imageView.heightAnchor.constraint(equalToConstant: screenSize.width / 2).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: screenSize.width / 2).isActive = true
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
	
	private func buildStatNameLanguage(_ text: String) -> UILabel {
		let label = UILabel()
		label.text = text
		label.font = UIFont.systemFont(ofSize: 20)
		label.textAlignment = .center
		label.textColor = UIColor.label
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
	
	private func buildStatTextExperience(_ text: String) -> UITextView {
		let textView = UITextView()
		textView.text = text
		textView.backgroundColor = UIColor.systemBackground
		textView.font = UIFont.systemFont(ofSize: 16)
		textView.textAlignment = .left
		textView.textColor = UIColor.label
		textView.isEditable = false
		textView.isSelectable = true
		textView.isScrollEnabled = false
		textView.layer.cornerRadius = SkillsTabLayout.textCornerRadius
		textView.backgroundColor = .lightText
		textView.translatesAutoresizingMaskIntoConstraints = false
		return textView
	}
}

extension SkillsTabView: ISkillsTabView {
	func didLoad() {
		configureUI()
		configureLayoutView()
		configureLayoutScrollView()
	}
	
	func setHistory(_ text: String) {
		self.historyText.text = text
	}
	
	func addStatistic(_ languageName: String,
					  _ languagePhotoName: String,
					  _ languageExperience: String) {
		self.addStatItem(languageName,
						 languagePhotoName,
						 languageExperience)
	}
}

private extension SkillsTabView {
	func configureUI() {
		self.backgroundColor = UIColor.systemBackground
	}
	
	func configureLayoutView() {
		let scrollArea = scrollView.contentLayoutGuide
		self.scrollView.addSubview(self.historyText)
		
		NSLayoutConstraint.activate([
			self.historyText.topAnchor.constraint(equalTo: scrollArea.topAnchor,
												   constant: SkillsTabLayout.scrollViewTopAnchor),
			self.historyText.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
													   constant: SkillsTabLayout.scrollViewLeadingAnchor),
			self.historyText.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
														constant: SkillsTabLayout.scrollViewTrailingAnchor)
		])
		
		guard statsStackView.count != 0 else {
			self.historyText.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
													  constant: SkillsTabLayout.scrollViewBottomAnchor).isActive = true
			return
		}
		
		for i in 0 ..< statsStackView.count {
			self.scrollView.addSubview(statsStackView[i])
			
			if i == 0 {
				statsStackView[i].topAnchor.constraint(equalTo: self.historyText.bottomAnchor,
													   constant: SkillsTabLayout.scrollViewTopAnchor).isActive = true
			}
			else {
				statsStackView[i].topAnchor.constraint(equalTo: statsStackView[i - 1].bottomAnchor,
													   constant: SkillsTabLayout.scrollViewTopAnchor).isActive = true
			}
			
			NSLayoutConstraint.activate([
				statsStackView[i].centerXAnchor.constraint(equalTo: scrollArea.centerXAnchor),
				statsStackView[i].leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor,
														   constant: SkillsTabLayout.scrollViewLeadingAnchor)
			])
			
			if i == statsStackView.count - 1 {
				NSLayoutConstraint.activate([
					statsStackView[i].trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor,
																constant: SkillsTabLayout.scrollViewTrailingAnchor),
					statsStackView[i].bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor,
															  constant: SkillsTabLayout.scrollViewBottomAnchor)
				])
			}
		}
	}
	
	func configureLayoutScrollView() {
		let safeArea = self.safeAreaLayoutGuide
		self.addSubview(scrollView)

		NSLayoutConstraint.activate([
			scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: safeArea.topAnchor),
			scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
			scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
			scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
			scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor)
		])
	}
}
