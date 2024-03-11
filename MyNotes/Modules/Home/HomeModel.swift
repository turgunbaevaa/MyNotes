//
//  HomeModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 27/2/24.
//
protocol HomeModelProtocol {
    func getNotes()
    func getSearchedNote(text: String)
    func deleteNoteAtIndex(index: Int)
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
        } else {
            filteredNotes = notes.filter { note in
                note.title!.lowercased().contains(text.lowercased())
            }
        }
        controller?.onSuccessNotes(notes: filteredNotes)
    }
    
    func deleteNoteAtIndex(index: Int) {
        // Ensure that index is within bounds
        guard index >= 0, index < notes.count else {
            return
        }
        
        let noteToDelete = notes[index]
        CoreDataService.shared.deleteNote(note: noteToDelete)
        notes.remove(at: index)
        controller?.onSuccessNotes(notes: notes)
    }
}
