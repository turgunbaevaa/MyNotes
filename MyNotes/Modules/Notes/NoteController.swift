//
//  NoteController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 14/3/24.
//

import Foundation

protocol NoteControllerProtocol {
    func onAddNote(note: Note?, title: String, description: String)
    
    func onSuccessUpdatedNote(note: Note?, id: String, title: String, description: String, date: String)
    
    func onSuccessAddNote()
    
    func onFailureAddNote()
    
    func onDeleteNote(id: String)
    
    func onSuccessDeleteNote()
    
    func onFailureDeleteNote()
}

class NoteController: NoteControllerProtocol {
    
    var view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
    
    func onAddNote(note: Note?, title: String, description: String) {
        model?.addNote(note: note, title: title, description: description)
    }
    
    func onSuccessUpdatedNote(note: Note?, id: String, title: String, description: String, date: String) {
        model?.updateNote(note: note, id: id, title: title, description: description, date: date)
    }
    
    func onSuccessAddNote() {
        view?.successAddNote()
    }
    
    func onFailureAddNote() {
        view?.failureAddNote()
    }
    
    func  onDeleteNote(id: String) {
        model?.deleteNote(id: id)
    }
    
    func onSuccessDeleteNote() {
        view?.successDeleteNote()
    }
    
    func onFailureDeleteNote() {
        view?.failureDeleteNote ()
    }
    
    
}
