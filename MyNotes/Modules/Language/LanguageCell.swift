//
//  LanguageCell.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 19/3/24.
//

import UIKit

struct Language {
    var img: String
    var language: String
}

class LanguageCell: UICollectionViewCell {
    
    static var reuseId = "language_cell"
    
    private lazy var languageImg: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var languageTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            make.top.equalToSuperview().offset(9)
            make.centerX.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
    }
    
    private func setupLanguageTitle(){
        addSubview(languageTitle)
        languageTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalTo(languageImg.snp.trailing).offset(91)
            make.centerX.equalToSuperview()
        }
        languageTitle.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 150
    }
    
    func setData(_ image: String, title: String) {
        languageImg.image = UIImage(named: image)
        languageTitle.text = title
    }
}
