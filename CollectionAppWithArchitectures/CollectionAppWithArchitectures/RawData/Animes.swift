//
//  Animes.swift
//  CollectionAppWithArchitectures
//
//  Created by Александр Фомин on 27.11.2021.
//

import Foundation

enum Animes {
	private static var animes: [Anime] = {
		let components = RawData.animeRawData.components(separatedBy: CharacterSet.newlines)
		var animes = [Anime]()
		
		for line in components {
			let animeComponents = line.components(separatedBy: ";")
			let imageName = animeComponents[0]
			let title = animeComponents[1]
			var tags = [String]()
			let tagComponents = animeComponents[2].components(separatedBy: ",")
			for tag in tagComponents {
				tags.append(tag)
			}
			let description = animeComponents[3]
			animes.append(Anime(imageName: imageName,
									 title: title,
									 tags: tags,
									 description: description))
		}
		
		return animes
	}()
}

extension Animes {
	static func getAnimes() -> [Anime] {
		animes
	}
	
	static func getAnime(animeIdentifier: UUID) -> Anime? {
		let anime = animes.filter { $0.identifier == animeIdentifier }.first
		
		return anime
	}
	
	static func getAnimeImageName(animeIdentifier: UUID) -> String? {
		let imageName = animes.filter { $0.identifier == animeIdentifier }.first?.imageName
		
		return imageName
	}
}

enum RawData {
	static let animeRawData = """
aprilLie;Твоя апрельская ложь;Драма,Комендия,Романтика,Музыка;Косэй Арима отличается от своих сверстников тем, что очень любит музыку. Он профессионально играет на фортепиано, выигрывает все детские конкурсы, поэтому о нем знали все начинающие музыканты. Мама Косэя работала его же тренером и наставником. После того, как она неожиданно скончалась, Косэй изменился полностью. У него произошел нервный срыв и он не мог уже играть так, как играл раньше. Он перестал чувствовать музыку. Казалось, что все вокруг такое пустое, такое безразличное. Все знали, что этот парень безумно талантлив, что у него отличный слух, но сейчас будто бы что-то произошло не то. Спустя несколько лет, Косэй не притрагивается к пианино. Мир ему был мерзок, все такое серое и монотонное. Одна радость оставалась - друзья Тсубаки и Ватари радовали главного героя.Однажды парень встречает прекрасной красоты девушку Каори. Она оказывается скрипачкой не менее талантливой, чем в свое время главный герой этой истории. Ариме показалось, что игра этой девушки, что ее музыка отражает душу парня. Каори хочет помочь вернутся Косею в музыкальный мир и снова почувствовать музыку.
91days;91 день;Драма,Мафия,Приключения,Экшен;На дворе 1920 год. В США действует сухой закон, который запрещает производство и сбыт алкогольной продукции, тем самым открывая для мафиозных семей новую нишу.В центре этих событий юный Анджело Лагуса, трагически потерявший своих родных в ходе междоусобиц внутри мафии. Ему удается скрыться от убийц и покинуть город. Но спустя годы, Анджело, потерявший всякий смысл жить, получает письмо от неизвестного отправителя, в которое были вписаны имена людей, причастных к гибели его семьи. Теперь, Анджело, движимый жаждой мести отправляется в родной Лорэл с единственной целью - отплатить тем, кто забрал жизни членов его семьи...
beck;Бек: Восточная Ударная Группа;Драма,Комедия,Романтика,Музыка;Главные герои этого аниме – группа молодых ребят, творчество которых не пришлось по душе руководству одного крупного лейбла. В результате подобного провала новоиспеченная группа вынуждена прозябать в маленьких клубах. Но однажды фортуна улыбнулась им, послав четырнадцатилетнего школьника Юкио, который оказался великолепным вокалистом. С его помощью группу ждет настоящее спасение и большой успех.
greatPretender;Великий притворщик;Комедия,Мафия,Приключения,Экшен,Психология;Не будет преувеличением сказать, что Масато Эдамура, вероятно, величайший в Японии мошенник. На пару с подельником Кудо он решает провернуть аферу в Асакусе и обмануть некоего Француза, однако в итоге оказывается обманут сам. Ведь Француз, которого они так неудачно пытались обдурить, оказался не кем-нибудь, а самим Лораном Тьерри — человеком такого высокого уровня, что ему подчиняется даже мафия. Теперь Эдамуре и Кудо придётся заниматься грязными делишками, которые поручает им Лоран, и ещё неизвестно, куда это их заведёт!
movingCastle;Ходячий замок;Драма,Приключения,Романтика,Фэнтези,Антивойна,Стимпанк;18-летнюю Софи злая ведьма заточила в тело старухи. Как ей вернуть свой облик? В поисках ответа Софи знакомится с сильным волшебником Хаулом и демоном огня Кальцифером. У Кальцифера с Хаулом договор, по которому он должен служить волшебнику. Софи и демон договариваются помочь друг другу избавиться от злых чар...
oddTaxi;Случайное такси;Детектив,Драма,Комедия,Полулюди;Таксист Одокава живёт серой однообразной жизнью. У него нет семьи, нет друзей, он чудаковатый, узко мыслящий и мало разговаривающий тип. Единственные его собеседники — это его врач Горики и его одноклассник из средней школы Какихана.Его клиенты и сами кажутся немного странными. Кабасава — студент колледжа, который хочет, чтобы мир заметил его в Интернете. Сиракава — загадочная медсестра, которая что-то скрывает. «Хомосапиенс» — комедийный дуэт, у которого не всё гладко с профессиональной деятельностью. Местный хулиган по имени Добу. Все они садятся в его такси, едут, ведут обычные разговоры, которые каким-то образом ведут к пропавшей девушке.
princessMononoke;Принцесса Мононоке;Драма,Приключения,Фэнтези,Экшен,Самураи,Полулюди;Чтобы защитить свою деревню от атак демона-бога, Аситака вступает в схватку с ним и возвращается со смертельным проклятием. В поисках лекарства, он навсегда покидает свою деревню и отправляется в лес, который населяют животные-боги. И вдруг он оказывается в центре войны между богами и лесной деревней, возглавляемой леди Эбоси.
silentVoice;Форма голоса;Драма,Повседневность,Школьная жизнь;История сложных судеб двух подростков. У героини проблемы со слухом, из-за чего в обычной школе она вызывала раздражение одноклассников. Раздражение вылилось в издевательства. Герой был одним из зачинщиков издевательств. Но хоть и были виноваты все, когда пришло время кого-то обвинить, только он стал общепризнанным злодеем. И новым объектом издевательств. Прошли годы, и у парня осталось лишь одно желание: попросить прощения...
spiritedAway;Унесённые призраками;Драма,Приключения,Фэнтези,Параллельные миры,Сверхъестественное;Девочка Тихиро вместе с родителями переезжают в свой новый дом. Сбившись с дороги, они оказываются в странном безлюдном городе, где столы ломятся от количества блюд. Родители с жадностью бросаются на еду и к ужасу и удивлению Тихиро превращаются в свиней. Они стали пленниками злой колдуньи Юбабы, хозяйки таинственного мира древних богов и могущественных духов. Тихиро решает во что бы то ни стало вернуть родителям их прежний облик.
vivy;Виви: Песнь флюоритового глаза;Андроиды,Триллер,Фантастика,Экшен,Музыка;История повествует нам о цифровом будущем. Сюжет разворачивается в тематическом парке с искусственным интеллектом «Nearland», где «мечты, надежда и наука» существуют вместе. В этом парке родился первый ИИ человеческого типа — Виви. Она поет на сцене для посетителей каждый день, так как в нее заложено «сделать всех счастливыми с помощью песни». Но однажды с Виви встречается другой ИИ по имени Мацумото и говорит, что пришел из будущего, чтобы «исправить историю и остановить войну между ИИ и людьми, которая разразится через 100 лет». Так начинается столетнее путешествие певицы Виви.
"""
}
