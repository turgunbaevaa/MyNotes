//
//  LanguageCell.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 19/3/24.
//

import UIKit
import SnapKit

struct Language {
    var img: String
    var language: String
}

class LanguageCell: UITableViewCell {
    
    static var reuseId = "language_cell"
    
    private lazy var languageImg: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 32/2
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var languageTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLanguageImg()
        setupLanguageTitle()
    }
    
    private func setupLanguageImg(){
        addSubview(languageImg)
        languageImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
    }
    
    private func setupLanguageTitle(){
        addSubview(languageTitle)
        languageTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
            //make.centerY.equalToSuperview()
        }
        languageTitle.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 150
    }
    
    func setData(_ image: String, title: String) {
        languageImg.image = UIImage(named: image)
        languageTitle.text = title
    }
}
