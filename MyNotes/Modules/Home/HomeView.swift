//
//  ViewController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 21/2/24.
//

import UIKit
import SnapKit

protocol HomeViewProtocol {
    func successNotes(notes: [Note])
}

//struct Note {
//    var title: String
//    var liked: Bool
//}

class HomeView: UIViewController {
    
    private var controller: HomeControllerProtocol?
    
    private var notes: [Note] = []
    
    private var filteredNotes: [Note] = []
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search"
        view.searchTextField.addTarget(self, action: #selector(noteSearchBarEditingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseID )
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = UIColor().rgb(r: 255, g: 61, b: 61, alpha: 1)
        button.layer.cornerRadius = 42/2
        return button
    }()
    
    private var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        controller = HomeController(view: self)
        controller?.onGetNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        setupNavigationItem()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupUI(){
        setupSearchBar()
        setupTitle()
        setupNotesCollections()
        setupButton()
    }

    private func setupNavigationItem() {
        navigationItem.title = "Home"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        if UserDefaults.standard.bool(forKey: "theme") == true {
            rightBarButtonItem.tintColor = .white
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            rightBarButtonItem.tintColor = .black
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func settingsButtonTapped(_ sender:UIButton){
        let vc = SettingsView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func likeButtonHandler(indexHandler: ([String]) -> ()){
//        indexHandler(notes)
//    }
    
    @objc func noteSearchBarEditingChanged(_ sender:UIButton){
        controller?.onSearchText(text: searchBar.text!)
    }
    
//    @objc func addButtonEditingChanged(){
//        if let text = searchBar.text {
//            
//            if text.isEmpty {
//                addButton.backgroundColor = .lightGray
//                addButton.isEnabled = false
//            } else {
//                addButton.backgroundColor = .red
//                addButton.isEnabled = true
//                //при первом открытии кнопка должна быть уже серой и только после заполнения красным
//                //это можно сделать при составлении функции для кнопки view.backgroundColor = .lightGray
//                //view.isEnabled = false
//            }
//        }
//    }
    
    private func setupSearchBar(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
    }
    
    private func setupTitle(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(40)
        }
    }
    private func setupNotesCollections(){
        view.addSubview(notesCollectionView)
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func setupButton(){
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-140)
            make.centerX.equalTo(view.snp.centerX)
            make.height.width.equalTo(42)
        }
        addButton.addTarget(self, action: #selector(addNotesButtonTapped), for: .touchUpInside)
    }
    
    @objc func addNotesButtonTapped(){
        let vc = NotesView()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseID, for: indexPath) as! NoteCell
        cell.fill(title: filteredNotes[indexPath.row].title ?? "")
        cell.index = indexPath.row
        cell.delegate = self 
        // Установила цвет текста ячейки черным
        cell.titleLabel.textColor = .black
        print(indexPath)
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12 ) / 2 , height: 100)
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [Note]) {
        self.notes = notes
        self.filteredNotes = notes
        notesCollectionView.reloadData()
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

extension HomeView: NoteCellDelegate {
    
    func didRemoveButton(index: Int) {
        notes.remove(at: index)
        notesCollectionView.reloadData()
    }
    
    func didLikedButton(index: Int) {
        let cell = notesCollectionView.cellForItem(at: [0, index]) as? NoteCell
        cell?.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
}

extension HomeView: UISearchBarDelegate {
    
}
