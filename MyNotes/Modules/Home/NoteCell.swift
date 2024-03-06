//
//  NoteCell.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 21/2/24.
//

import UIKit
import SnapKit

protocol NoteCellDelegate: AnyObject {
    func didRemoveButton(index: Int)
    
    func didLikedButton(index: Int)
}

class NoteCell: UICollectionViewCell {
    
    static var reuseID = "note_cell"
    
    var view: HomeView?
    
    var index: Int?
    
    //var indexHandler: ([String]) -> ()
    
    let colors: [UIColor] = [.systemCyan, .systemPink, .systemCyan, .systemYellow]
    
    weak var delegate: NoteCellDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "trash"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
        setupConstraints()
    }
    
    @objc private func deleteButtonTapped(){
        print("delete")
        guard let index = index else {
            return
        }
        delegate?.didRemoveButton(index: index)
    }
    
    var isLiked = false
    
    @objc func likeButtonTapped() {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isLiked = false
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isLiked = true
        }
        guard let index = index else {
            return
        }
        delegate?.didLikedButton(index: index)
        print("liked")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(title: String) {
        titleLabel.text = title
    }
    
    private func setupConstraints(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.width.equalTo(40 )
        }
        
        contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(40)
        }
    }
}
