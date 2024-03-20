//
//  SettingsView.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit
import SnapKit

protocol SettingsViewProtocol {
    func successDeleteNotes()
    
    func failureDeleteNotes()
}

class SettingsView: UIViewController {
    
    var controller: SettingsControllerProtocol?
    
    private let settingsTableView = UITableView()
    
    private lazy var setData: [Settings] = [
        Settings(image: "globe", title: "Choose language".localized(), type: .withButton, language: "English".localized()),
        Settings(image: "moon", title: "Dark theme".localized(), type: .withSwitch, language: ""),
        Settings(image: "trash", title: "Clear data".localized(), type: .none, language: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = SettingsController(view: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupUI(){
        setupSettingsTableView()
    }
    
    private func setupData() {
        setData = [Settings(image: "globe", title: "Choose language".localized(), type: .withButton, language: "English"),
                   Settings(image: "moon", title: "Dark theme".localized(), type: .withSwitch, language: ""),
                   Settings(image: "trash", title: "Clear data".localized(), type: .none, language: "")]
        settingsTableView.reloadData()
        }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings".localized()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
    }
    
    private func setupSettingsTableView(){
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseID)
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(150)
        }
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseID, for: indexPath) as! SettingsCell
        cell.setup(settings: setData[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let alert  = UIAlertController(title: "Удаление".localized(), message: "Вы уверены что хотите удалить заметку?".localized(), preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Да".localized(), style: .destructive) { action in
                self.controller?.onDeleteNotes()
            }
            let declineAction = UIAlertAction(title: "Нет".localized(), style: .cancel)
            
            alert.addAction(declineAction)
            alert.addAction(acceptAction)
            present(alert, animated: true)
            
        } else if indexPath.row == 0 {
            let languageView = LanguageView()
            languageView.delegate = self
            let multiplier = 0.25
            let customDetent = UISheetPresentationController.Detent.custom(resolver: { context in
                languageView.view.frame.height * multiplier
            })
            if let sheet = languageView.sheetPresentationController {
                sheet.detents = [customDetent, .medium()]
                sheet.prefersGrabberVisible = true
            }
            self.present(languageView, animated: true)
        }
    }
}

extension SettingsView: SettingsViewProtocol {
    func successDeleteNotes() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDeleteNotes() {
        let alert = UIAlertController(title: "Ошибка".localized(), message: "Не удалось удалить заметку".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}

extension SettingsView: SettingsCellDelegate {
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}

extension SettingsView: LanguageViewDelegate {
    func didLanguageSelected(languageType: LanguageType) {
        setupNavigationItem()
        setupData()
    }
}
