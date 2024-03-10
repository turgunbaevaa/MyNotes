//
//  NotesView.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 8/3/24.
//

import UIKit
import SnapKit

class NotesView: UIViewController {
    
    private let coreDataService = CoreDataService.shared
    
    private lazy var titleBox: UITextView = {
        let view = UITextView()
        view.autocorrectionType = .no
        view.layer.cornerRadius = 17
        view.layer.borderWidth = 0.5
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.textContainer.lineBreakMode = .byWordWrapping
        return view
    }()
    
    private lazy var textBox: UITextView = {
        let view = UITextView()
        view.autocorrectionType = .no
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor().rgb(r: 238, g: 238, b: 239, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor().rgb(r: 255, g: 61, b: 61, alpha: 1)
        //view.isEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI(){
        setupTitleBox()
        setupTextBox()
        setupSaveButton()
    }
    
    private func setupTitleBox(){
        view.addSubview(titleBox)
        titleBox.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(22)
            make.trailing.equalTo(view.snp.trailing).offset(-22)
            make.height.equalTo(34)
        }
    }
    
    private func setupTextBox(){
        view.addSubview(textBox)
        textBox.snp.makeConstraints { make in
            make.top.equalTo(titleBox.snp.bottom).offset(25)
            make.leading.equalTo(view.snp.leading).offset(22)
            make.trailing.equalTo(view.snp.trailing).offset(-22)
            make.height.equalTo(475)
        }
    }
    
    private func setupSaveButton(){
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            make.leading.equalTo(view.snp.leading).offset(22)
            make.trailing.equalTo(view.snp.trailing).offset(-22)
            make.height.equalTo(42)
        }
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped(){
        let id = UUID().uuidString
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        coreDataService.addNote(id: id, title: titleBox.text ?? "", description: textBox.text ?? "", date: dateString )
    }
}
