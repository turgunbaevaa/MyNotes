//
//  CoreDataService.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 9/3/24.
//

import UIKit
import CoreData

//CRUD - Create Read Update Delete
//POST - Create
//GET(FETCH) - Read
//PUT(PATCH) - Update
//DELETE - Delete

enum CoredataResponse {
    case success
    case failure
}

class CoreDataService {
    
    static var shared = CoreDataService()
    
    private init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //post запрос
    func addNote(id: String, title: String, description: String, date: String, completionHandler: @escaping (CoredataResponse) -> Void){
        guard let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {
            DispatchQueue.main.async {
                completionHandler(.failure)
            }
            return
        }
        
        let note = Note(entity: noteEntity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        
        appDelegate.saveContext()
        DispatchQueue.main.async {
            completionHandler(.success)
        }
    }
    
    //read запрос
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    //update запрос
    func updateNote(id: String, title: String, description: String, date: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id
            }) else {
                return
            }
            note.title = title
            note.desc = description
            note.date = date
            
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    //delete запрос
    func deleteNote(id: String, completionHandler: @escaping (CoredataResponse) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id
            }) else {
                DispatchQueue.main.async {
                    completionHandler(.failure)
                }
                return
            }
            context.delete(note)
            DispatchQueue.main.async {
                completionHandler(.success)
            }
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure)
            }
        }
        appDelegate.saveContext()
    }
    
    func deleteNotes(completionHandler: @escaping (CoredataResponse) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note] else {
                completionHandler(.failure)
                return
            }
            notes.forEach { note in
                context.delete(note)
            }
            DispatchQueue.main.async {
                completionHandler(.success)
            }
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure)
            }
        }
        appDelegate.saveContext()
    }
}
