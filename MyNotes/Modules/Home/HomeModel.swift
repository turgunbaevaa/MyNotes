//
//  HomeModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 27/2/24.
//
protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [String] = ["Do a homework", "Go to the gym", "Buy a ticket", "Submit tasks"]
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
    
}
