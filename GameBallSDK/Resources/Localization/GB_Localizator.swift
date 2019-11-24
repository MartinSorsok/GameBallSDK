//
//  Localizator.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/19/19.
//

public class GB_Localizator {
    
    static let sharedInstance = GB_Localizator()
    var language: Languages = .english
    
    lazy var localizableEnglishDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "GB_Localizable", ofType: "strings") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    lazy var localizableArabicDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "GB_LocalizableArabic", ofType: "strings") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    func localize(string: String , language: String = GB_Localizator.sharedInstance.language.rawValue ) -> String {
        if language == Languages.english.rawValue {
        guard let localizedString = localizableEnglishDictionary.value(forKey: string) as? String else {
            assertionFailure("Missing translation for: \(string)")
            return ""
            }

            return localizedString
        } else {
            guard let localizedString = localizableArabicDictionary.value(forKey: string) as? String else {
                assertionFailure("Missing translation for: \(string)")
                return ""
            }

            return localizedString
        }
    }
}

extension String {
    var localized: String {
        return GB_Localizator.sharedInstance.localize(string: self)
    }
}

enum Languages :String {
    case english = "en"
    case arabic = "ar"
}
