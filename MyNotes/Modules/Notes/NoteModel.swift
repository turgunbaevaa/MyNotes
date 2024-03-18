//
//  NoteModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 14/3/24.
//

import Foundation

protocol NoteModelProtocol {
    func addNote(note: Note?, title: String, description: String)
    
    func updateNote(note: Note?, id: String, title: String, description: String, date: String)
    
    func deleteNote(id: String)
}

class NoteModel: NoteModelProtocol {
    
    private let coreDataService = CoreDataService.shared
    
    var controller: NoteControllerProtocol?
    
    init(controller: NoteControllerProtocol){
        self.controller = controller
    }
    
//    func addNote(note: Note?, title: String, description: String) {
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
//        let date = dateFormatter.string(from: currentDate)
//        let id = UUID().uuidString
//        coreDataService.addNote(id: id, title: title, description: description, date: date) { response in
//            if response == .success {
//                self.controller?.onSuccessAddNote()
//            } else {
//                self.controller?.onFailureAddNote()
//            }
//        }
//        controller?.onSuccessAddNote()
//    }
    func addNote(note: Note?, title: String, description: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd - HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        if let note = note {
            coreDataService.updateNote(id: note.id ?? "", title: title, description: description, date: dateString)
        } else {
            let id = UUID().uuidString
            coreDataService.addNote(id: id, title: title, description: description, date: dateString) { response in
                if response == .success {
                    self.controller?.onSuccessAddNote()
                } else {
                    self.controller?.onFailureAddNote()
                }
            }
        }
    }
    
    func updateNote(note: Note?, id: String, title: String, description: String, date: String) {
        if let note = note {
            coreDataService.updateNote(id: note.id!, title: title, description: description, date: date)
            }
        }
    
    func deleteNote(id: String) {
        coreDataService.deleteNote(id: id) { response in
            if response == .success {
                self.controller?.onSuccessDeleteNote()
            } else {
                self.controller?.onFailureDeleteNote()
            }
        }
    }
}
