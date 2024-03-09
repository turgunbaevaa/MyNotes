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
    
    private var notes: [String] = ["Do a homework", "Go to the gym", "Buy a ticket", "Submit tasks"]
    private var filteredNotes: [String] = []
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
    
    func getSearchedNote(text: String) {
        filteredNotes = []
        if text.isEmpty {
            filteredNotes = notes
        } else {
            filteredNotes = notes.filter { note in
                note.lowercased().contains(text.lowercased())
            }
        }
        controller?.onSuccessNotes(notes: filteredNotes)
    }
}
