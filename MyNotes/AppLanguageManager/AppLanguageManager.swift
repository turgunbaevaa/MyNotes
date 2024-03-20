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

class AppLanguageManager {
    static let shared = AppLanguageManager()
    
    private var currentLanguage: LanguageType?
    
    private var currentBundle: Bundle = Bundle.main
    
    var bundle: Bundle {
        return currentBundle
    }
    
    func setAppLanguage(language: LanguageType) {
        setCurrentLanguage(language: language)
        setCurrentBundlePath(languageCode: language.rawValue)
    }
    
    private func setCurrentLanguage(language: LanguageType){
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: "selectedLanguage")
        //TODO: Добавить сохранение в UserDefaults
        
        let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage")
        if let selectedLanguage = savedLanguage {
            // Используйте выбранный язык
            currentLanguage = language
        }
        
        
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
