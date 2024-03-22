//
//  AppLanguageManager.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 19/3/24.
//

import Foundation

enum LanguageType: String {
    case kg = "ky-KG"
    case ru = "ru"
    case en = "en"
}

enum AppLanguageManagerResponse {
    case success
    case failure
}

class AppLanguageManager {
    static let shared = AppLanguageManager()
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
    func setAppLanguage(language: LanguageType, completionHandler: @escaping (AppLanguageManagerResponse) -> Void) {
        setCurrentLanguage(language: language)
        setCurrentBundlePath(languageCode: language.rawValue)
        DispatchQueue.main.async {
            completionHandler(.success)
        }
    }
    
    private func setCurrentLanguage(language: LanguageType){
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: "selectedLanguage")
    }
    
    private func setCurrentBundlePath(languageCode: String){
        guard let bundle = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let langBundle = Bundle(path: bundle) else {
            currentBundle = Bundle.main
            return
        }
        currentBundle = langBundle
    }
}

extension String {
    func localized() -> String {
        let bundle = AppLanguageManager.shared.bundle
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
    }
    
}
