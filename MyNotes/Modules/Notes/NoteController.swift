//
//  NoteController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 14/3/24.
//

import Foundation

protocol NoteControllerProtocol {
    func onAddNote(note: Note?, id: String, title: String, description: String, date: String)
    
    func onSuccessDeletedNote()
    
    func onSuccessUpdatedNote(note: Note?, id: String, title: String, description: String, date: String)
    
    func onSuccessAddNote()
    
    func onFailureAddNote()
}

class NoteController: NoteControllerProtocol {
    
    func onAddNote(note: Note?, id: String, title: String, description: String, date: String) {
        model?.addNote(note: note, id: id, title: title, description: description, date: date )
    }
    
    func onSuccessDeletedNote() {
        view?.successDeleteNote()
    }
    
    func onSuccessUpdatedNote(note: Note?, id: String, title: String, description: String, date: String) {
        model?.updateNote(note: note, id: id, title: title, description: description, date: date)
    }
    
    func onSuccessAddNote() {
        view?.successAddNote()
    }
    
    func onFailureAddNote() {
        ()
    }
    
    var view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
}
