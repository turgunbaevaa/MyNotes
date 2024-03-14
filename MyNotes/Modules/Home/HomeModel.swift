//
//  HomeModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 27/2/24.
//
protocol HomeModelProtocol {
    func getNotes()
     
    func getSearchedNote(text: String)
}

class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [Note] = []
    
    private var filteredNotes: [Note] = []
    
    private let coreDataService = CoreDataService.shared
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
    
    func getSearchedNote(text: String) {
        filteredNotes = []
        if text.isEmpty {
            filteredNotes = notes
            controller?.onSuccessNotes(notes: notes)
        } else {
            filteredNotes = notes.filter { note in
                note.title!.lowercased().contains(text.lowercased())
            }
            controller?.onSuccessNotes(notes: filteredNotes)
        }
    }
}
