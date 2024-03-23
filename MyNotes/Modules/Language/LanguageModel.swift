//
//  LanguageModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 22/3/24.
//

import UIKit

protocol LanguageModelProtocol {
    func selectLanguage(language: LanguageType, completionHandler: @escaping (AppLanguageManagerResponse) -> Void)
}

class LanguageModel: LanguageModelProtocol {
    
    var controller: LanguageControllerProtocol?
    private let appLanguageManager = AppLanguageManager.shared
    
    init(controller: LanguageControllerProtocol){
        self.controller = controller
    }
    
    func selectLanguage(language: LanguageType, completionHandler: @escaping (AppLanguageManagerResponse) -> Void) {
        appLanguageManager.setAppLanguage(language: language) { response in
            DispatchQueue.main.async {
                switch response {
                case .success:
                    self.controller?.onSuccessSelectLanguage(language: language)
                case .failure:
                    completionHandler(.failure)
                }
            }
        }
    }
}
