//
//  SettingsTableViewCell.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit
import SnapKit

class SettingsTableViewCell: UITableViewCell {
    
    static let reuseID = "note_cell"
    
    private lazy var settingsImg: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var settingsTitle: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.textColor = UIColor.label
        return view
    }()
    
    var button: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        view.setTitle("Русский", for: .normal)
        view.setTitleColor(.secondaryLabel, for: .normal)
        view.tintColor = .black
        view.semanticContentAttribute = .forceRightToLeft
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        return view
    }()
    
    var switchButton: UISwitch = {
        let view = UISwitch()
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
    
    private func setupUI() {
        setupSettingsImg()
        setupSettingsTitle()
        setupSettingsButton()
        setupSettingsSwitchButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingsImg.image = nil
        settingsTitle.text = nil
    }
    
    func setup(title: String) {
        settingsTitle.text = title
    }
    
    func setup(image: UIImage) {
        settingsImg.image = image
    }
    
    private func setupSettingsImg(){
        contentView.addSubview(settingsImg)
        settingsImg.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(16)
            make.width.height.equalTo(24)
        }
    }
    
    private func setupSettingsTitle(){
        contentView.addSubview(settingsTitle)
        settingsTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(settingsImg.snp.trailing).offset(13)
        }
    }
    private func setupSettingsButton(){
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
        }
    }
    
    private func setupSettingsSwitchButton(){
        contentView.addSubview(switchButton)
        switchButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
        }
    }
}
