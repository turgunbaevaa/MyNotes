//
//  NoteModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 14/3/24.
//

import Foundation

protocol NoteModelProtocol {
    func addNote(note: Note?, id: String, title: String, description: String, date: String)
    
    func deleteNote(note: Note?, id: String)
    
    func updateNote(note: Note?, id: String, title: String, description: String, date: String)
}

class NoteModel: NoteModelProtocol {
    
    private let coreDataService = CoreDataService.shared
    
    var controller: NoteControllerProtocol?
    
    init(controller: NoteControllerProtocol){
        self.controller = controller
    }
    
    func addNote(note: Note?, id: String, title: String, description: String, date: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = dateFormatter.string(from: currentDate)
        let id = UUID().uuidString
        coreDataService.addNote(id: id, title: title, description: description, date: date)
        //TODO: change after (with alert depending on the respons of the CoreData)
        //navigationController?.popToRootViewController(animated: true)
        controller?.onSuccessAddNote()
    }
    
    
    func deleteNote(note: Note?, id: String) {
        guard let note = note else {
            return
        }
        coreDataService.deleteNote(id: note.id!)
        controller?.onSuccessDeletedNote()
    }
    
    func updateNote(note: Note?, id: String, title: String, description: String, date: String) {
        if let note = note {
            coreDataService.updateNote(id: note.id!, title: title, description: description, date: date)
        }
        controller?.onSuccessUpdatedNote(note: note, id: id, title: title, description: description, date: date)
    }
}
