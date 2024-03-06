//
//  SettingsVC.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit

protocol SettingsViewProtocol {
    
}

class SettingsVC: UIViewController {
    
    //weak var controller: SettingsViewProtocol?
    var controller: SettingsControllerProtocol?
    
    private let settingsTableView = UITableView()
    
    private var settings: [Settings] = [
        Settings(image: "globe", title: "Язык", type: .withButton, language: "Русский"),
        Settings(image: "moon", title: "Темная тема", type: .withSwitch, language: ""),
        Settings(image: "trash", title: "Очистить", type: .none, language: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        controller = SettingsController(view: self)
        setupUI()
    }
    
    private func setupUI(){
        setupNavigationItem()
        setupSettingsTableView()
    }
    
    deinit {
        print("Экран настроек пропал из вида и уничтожился")
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings"
        let image = UIImage(named: "settings")
        let resizedImage = image?.resized(to: CGSize(width: 25, height: 25))
        let rightBarButtonItem = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(settingsButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupSettingsTableView(){
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseID)
        settingsTableView.dataSource = self
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(150)
        }
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton){
        
    }
}

extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseID, for: indexPath) as! SettingsCell
        cell.setup(settings: settings[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SettingsVC: SettingsViewProtocol {
    
}

extension SettingsVC: SettingsCellDelegate {
    func didSwitchOn(isOn: Bool) {
        if isOn {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}
