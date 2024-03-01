//
//  SettingsVC.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let settingsTableView = UITableView()
    
    let settingsList: [SettingsList] = [
        SettingsList(image: UIImage(named: "language"), settingsName: "Язык", settingsButton: "chevron.right"),
        SettingsList(image: UIImage(named: "moon"), settingsName: "Темная тема", settingsButton: "switch.2"),
        SettingsList(image: UIImage(named: "trash"), settingsName: "Очистить данные", settingsButton: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI(){
        setupNavigationItem()
        setupContactTableView()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings"
        
        let image = UIImage(named: "settings")
        let resizedImage = image?.resized(to: CGSize(width: 25, height: 25))
        let rightBarButtonItem = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(settingsButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupContactTableView(){
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseID)
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
        settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as! SettingsTableViewCell
        
        print("Configuring cell for row \(indexPath.row)")
        
        if indexPath.row == 0 {
            cell.contentView.addSubview(cell.button)
        } else {
            cell.button.removeFromSuperview()
        }
        
        if indexPath.row == 1 {
            cell.contentView.addSubview(cell.switchButton)
        } else {
            cell.switchButton.removeFromSuperview()
        }
        
        if let image = settingsList[indexPath.row].image {
            cell.setup(image: image)
        }
        
        cell.setup(title: settingsList[indexPath.row].settingsName)
        
        return cell
    }
}
