//
//  OnBoardCell.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 7/3/24.
//

import UIKit
import SnapKit

struct OnBoard {
    var image: String
    var title: String
    var descTitle: String
}

class OnBoardCell: UICollectionViewCell {
    
    static var reuseId = "on_board_cell"
    
    private lazy var onBoardImg: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var onBoardTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var onBoardDescription: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupOnBoardImg()
        setupOnBoardTitle()
        setupOnBoardDescription()
    }
    
    private func setupOnBoardImg(){
        addSubview(onBoardImg)
        onBoardImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(136)
            make.centerX.equalToSuperview()
            make.width.equalTo(212)
            make.height.equalTo(140)
        }
    }
    
    private func setupOnBoardTitle(){
        addSubview(onBoardTitle)
        onBoardTitle.snp.makeConstraints { make in
            make.top.equalTo(onBoardImg.snp.bottom).offset(52)
            make.horizontalEdges.equalToSuperview().inset(75)
            make.centerX.equalToSuperview()
        }
        onBoardTitle.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 150
    }
    
    private func setupOnBoardDescription(){
        addSubview(onBoardDescription)
        onBoardDescription.snp.makeConstraints { make in
            make.top.equalTo(onBoardTitle.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        onBoardDescription.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 80
    }
    
    func setData(_ image: String, title: String, descTitle: String) {
        onBoardImg.image = UIImage(named: image)
        onBoardTitle.text = title
        onBoardDescription.text = descTitle
    }
}
