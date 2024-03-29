//
//  HomeController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 27/2/24.
//
protocol HomeControllerProtocol {
    func onGetNotes()
    
    func onSuccessNotes(notes: [Note])
    
    func onNoteSearch(text: String)
    
    func onSearchResult(notes: [Note])
}

class HomeController: HomeControllerProtocol {
    
    private var view: HomeViewProtocol?
    private var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccessNotes(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
    
    func onNoteSearch(text: String) {
        model?.getSearchedNote(text: text)
    }
    
    func onSearchResult(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
}
