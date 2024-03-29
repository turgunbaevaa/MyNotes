//
//  AppDelegate.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 21/2/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Определение замыкания для обработки результата установки языка
        let languageSetupCompletion: (AppLanguageManagerResponse) -> Void = { response in
            DispatchQueue.main.async {
                // Обработка успешной или неудачной установки языка
                switch response {
                case .success:
                    // Действия при успешной установке языка
                    print("Язык успешно установлен.")
                case .failure:
                    // Действия при неудачной установке языка
                    print("Не удалось установить язык.")
                }
            }
        }
        // Проверяем, сохранен ли язык в UserDefaults
        if let savedLanguageString = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let savedLanguage = LanguageType(rawValue: savedLanguageString) {
            // Устанавливаем сохраненный язык
            AppLanguageManager.shared.setAppLanguage(language: savedLanguage, completionHandler: languageSetupCompletion)
        } else {
            // Если язык не сохранен, устанавливаем английский язык
            AppLanguageManager.shared.setAppLanguage(language: .en, completionHandler: languageSetupCompletion)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Note")
        container.loadPersistentStores ( completionHandler: { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as? Error
                fatalError(error!.localizedDescription)
            }
        }
    }
}

