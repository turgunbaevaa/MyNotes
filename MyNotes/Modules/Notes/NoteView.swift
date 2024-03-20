//
//  NoteView.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 8/3/24.
//

import UIKit
import SnapKit

protocol NoteViewProtocol {
    func successAddNote()
    
    func failureAddNote()
    
    func successUpdatedNote()
    
    func successDeleteNote()
    
    func failureDeleteNote()
    
}

class NoteView: UIViewController {
    
    var controller: NoteControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    var note: Note?
    
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
    
    private lazy var copyButton: UIButton = {
            let view = UIButton(type: .system)
            view.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
            view.tintColor = .lightGray
            return  view
        }()
        
        private lazy var notesDateLabel: UILabel = {
            let view = UILabel()
            view.textColor = .secondaryLabel
            view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            return view
        }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save".localized(), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor().rgb(r: 255, g: 61, b: 61, alpha: 1)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = NoteController(view: self)
        view.backgroundColor = .systemBackground
        setupUI()
        guard let note = note else {
            return
        } 
        titleBox.text = note.title
        textBox.text = note.desc
        notesDateLabel.text = note.date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupNavigationItem() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashButtonTapped))
        if UserDefaults.standard.bool(forKey: "theme") == true {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func copyButtonTapped(){
        guard let textToCopy = textBox.text else { return }
        UIPasteboard.general.string = textToCopy
    }
    
    @objc func trashButtonTapped(){
        guard let note = note else {
            return
        }
        let alert  = UIAlertController(title: "Удаление".localized(), message: "Вы уверены что хотите удалить заметку?".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Да".localized(), style: .destructive) { action in
            self.controller?.onDeleteNote(id: note.id ?? "")
        }
        let declineAction = UIAlertAction(title: "Нет".localized(), style: .cancel)
        
        alert.addAction(declineAction)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    private func setupUI(){
        setupTitleBox()
        setupTextBox()
        setupNotesDateLabel()
        setupCopyButton()
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
        titleBox.delegate = self
    }
    
    private func setupTextBox(){
        view.addSubview(textBox)
        textBox.snp.makeConstraints { make in
            make.top.equalTo(titleBox.snp.bottom).offset(25)
            make.leading.equalTo(view.snp.leading).offset(22)
            make.trailing.equalTo(view.snp.trailing).offset(-22)
            make.height.equalTo(475)
        }
        textBox.delegate = self
    }
    
    private func setupCopyButton(){
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.bottom.equalTo(textBox.snp.bottom).offset(-12)
            make.trailing.equalTo(textBox.snp.trailing).offset(-15)
            make.height.width.equalTo(32)
        }
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
    }
    
    private func setupNotesDateLabel(){
        view.addSubview(notesDateLabel)
        notesDateLabel.snp.makeConstraints { make in
            make.top.equalTo(textBox.snp.bottom).offset(6)
            make.trailing.equalTo(textBox.snp.trailing).offset(-20)
            make.height.equalTo(17)
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
        if let note = note {
            controller?.onSuccessUpdatedNote(note: note, id: note.id ?? "", title: titleBox.text ?? "", description: textBox.text ?? "", date: notesDateLabel.text ?? "")
            successUpdatedNote()
        } else {
            controller?.onAddNote(note: nil, title: titleBox.text ?? "", description: textBox.text ?? "")
            successAddNote()
        }
    }
    
    private func updateSaveButtonState() {
        if titleBox.text?.count != 0 || textBox.text?.count != 0 {
            // Если текстовое поле не пустое, активируем кнопку сохранения и меняем ее текст
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor().rgb(r: 255, g: 61, b: 61, alpha: 1)
        } else {
            // Если текстовое поле пустое, деактивируем кнопку сохранения и меняем ее текст
            saveButton.isEnabled = false
            saveButton.backgroundColor = .lightGray
        }
    }
}

extension NoteView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleBox {
            print("Entered text in titleBox: \(titleBox.text ?? ""), count: \(titleBox.text?.count ?? 0)")
        } else if textView == textBox {
            print("Entered text in textBox: \(textBox.text ?? ""), count: \(textBox.text?.count ?? 0)")
        }
        updateSaveButtonState()
    }
}


extension NoteView: NoteViewProtocol {
    func successAddNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureAddNote() {
        let alert = UIAlertController(title: "Ошибка".localized(), message: "Не удалось сохранить заметку".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    func successUpdatedNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func successDeleteNote() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDeleteNote() {
        let alert = UIAlertController(title: "Ошибка".localized(), message: "Не удалось удалить заметку".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}
