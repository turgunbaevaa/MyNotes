//
//  LanguageView.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 19/3/24.
//

import UIKit
import SnapKit

class LanguageView: UIViewController {
    
    private var languages: [Language] = [Language(img: "", language: "Кыргызча"), Language(img: "", language: "Русский"), Language(img: "", language: "English")]
    
    private lazy var languagesCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(LanguageCell.self, forCellWithReuseIdentifier: LanguageCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        setupLanguagesCollectionView()
    }
    
    private func setupLanguagesCollectionView(){
        view.addSubview(languagesCollectionView)
        languagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(0)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension LanguageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return languages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LanguageCell.reuseId, for: indexPath) as! LanguageCell
        cell.setData(languages[indexPath.row].img, title: languages[indexPath.row].language)
        return cell
    }
}

extension LanguageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
