//
//  SettingsTableViewCell.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit
import SnapKit

enum SettingsCellType {
    case none
    case withSwitch
    case withButton
}

struct Settings {
    var image: String
    var title: String
    var type: SettingsCellType
    var language: String
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitchOn(isOn: Bool)
}

class SettingsCell: UITableViewCell {
    
    private let coreDataService = CoreDataService.shared
    static let reuseID = "settings_cell"
    
    weak var delegate: SettingsCellDelegate?
    
    private lazy var settingsImg: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var settingsTitle: UILabel = {
        let view = UILabel()
        return view
    }()
    
    var button: UIButton = {
        let view = UIButton(type: .system)
        view.semanticContentAttribute = .forceLeftToRight
        return view
    }()
    
    var switchButton: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        view.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged(){
        delegate?.didSwitchOn(isOn: switchButton.isOn)
    }
    
    private func setupUI() {
        setupSettingsImg()
        setupSettingsTitle()
        setupSettingsButton()
        setupSettingsSwitchButton()
    }
    
    func setup(settings: Settings) {
        settingsImg.image = UIImage(systemName: settings.image)
        settingsTitle.text = settings.title
        
        switch settings.type {
        case .none:
            button.isHidden = true
            switchButton.isHidden = true
        case .withSwitch:
            button.isHidden = true
            switchButton.isHidden = false
        case .withButton:
            button.isHidden = false 
            switchButton.isHidden = true
            button.setTitle(settings.language.localized(), for: .normal)
        }
    }
    
    private func setupSettingsImg(){
        addSubview(settingsImg)
        settingsImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
    }
    
    private func setupSettingsTitle(){
        addSubview(settingsTitle)
        settingsTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(settingsImg.snp.trailing).offset(13)
            make.height.equalTo(24)
        }
    }
    private func setupSettingsButton(){
        addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func setupSettingsSwitchButton(){
        addSubview(switchButton)
        switchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
}
