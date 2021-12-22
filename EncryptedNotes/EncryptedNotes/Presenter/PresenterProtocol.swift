//
//  PresenterProtocol.swift
//  EncryptedNotes
//
//  Created by ayaz on 29.11.2021.
//

import Foundation

protocol PresenterProtocol {
    
    var notesTableView: Viewable { get set }
    var notes: Notes { get set }
    
    func getNotesCount() -> Int
    func getNoteHeader(noteNumber: Int) -> String
	func saveNewNote(header: String, text: String) 
	func deleteNote(noteNumber: Int)
	func changeNote(noteNumber: Int, header: String, text: String)
	func getNoteText(noteNumber: Int) -> String
	func isEncrypted(noteNumber: Int) -> Bool
	func encryptNote(noteNumber: Int, password: String)
	func decryptNote(noteNumber: Int, password: String) throws
}
