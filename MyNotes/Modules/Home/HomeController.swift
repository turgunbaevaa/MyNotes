//
//  HomeController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 27/2/24.
//
protocol HomeControllerProtocol {
    func onGetNotes()
    
    func onSuccessNotes(notes: [Note])
    
    func onSearchText(text: String)
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
    
    func onSearchText(text: String) {
        model?.getSearchedNote(text: text)
    }
}
