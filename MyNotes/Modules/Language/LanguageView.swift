//
//  LanguageView.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 19/3/24.
//

import UIKit
import SnapKit

protocol LanguageViewDelegate: AnyObject {
    func didLanguageSelected(languageType: LanguageType)
}

class LanguageView: UIViewController {
    
    private var languages: [Language] = [Language(img: "kg", language: "Кыргызча"), 
                                         Language(img: "rus", language: "Русский"),
                                         Language(img: "usa", language: "English")]
    
    weak var delegate: LanguageViewDelegate?
    
    private lazy var chooseLanguageTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = "Choose language".localized()
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        view.textAlignment = .left
        return view
    }()
    
    private lazy var languagesTableView = {
        let view = UITableView()
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseId)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        setupTitleLabel()
        setupLanguagesTableView()
    }
    
    private func setupTitleLabel(){
        view.addSubview(chooseLanguageTitle)
        chooseLanguageTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(view.snp.leading).offset(20)
            
        }
    }
    
    private func setupLanguagesTableView(){
        view.addSubview(languagesTableView)
        languagesTableView.snp.makeConstraints { make in
            make.top.equalTo(chooseLanguageTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(150)
        }
    }
}

extension LanguageView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseId, for: indexPath) as! LanguageCell
        cell.setData(languages[indexPath.row].img, title: languages[indexPath.row].language)
        return cell
    }
    
}

extension LanguageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: 
            AppLanguageManager.shared.setAppLanguage(language: .kg)
            delegate?.didLanguageSelected(languageType: .kg)
        case 1:
            AppLanguageManager.shared.setAppLanguage(language: .ru)
            delegate?.didLanguageSelected(languageType: .ru)
        case 2:
            AppLanguageManager.shared.setAppLanguage(language: .en)
            delegate?.didLanguageSelected(languageType: .en)
        default:
            ()
        }
        dismiss(animated: true)
    }
}
