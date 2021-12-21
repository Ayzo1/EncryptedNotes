import Foundation

final class Presenter: PresenterProtocol {
    
    var notesTableView: Viewable
    var notes: Notes
    
    init (notesTableView: Viewable, notes: Notes) {
        self.notesTableView = notesTableView
        self.notes = notes
    }
    
    public func getNotesCount() -> Int {
        print(notes.count())
        return notes.count()
    }
    
    public func getNoteHeader(noteNumber: Int) -> String {
		let note = notes.notes[noteNumber] as Note
		return note.header ?? "Error"
    }
	
	public func getNoteText(noteNumber: Int) -> String {
		let note = notes.notes[noteNumber] as Note
		return note.text ?? "Error"
	}
	
	public func saveNewNote (header: String, text: String) {
		notes.addNote(header: header, text: text)
	}
	
	func changeNote(noteNumber: Int, header: String, text: String) {
		notes.notes[noteNumber].header = header
		notes.notes[noteNumber].text = text
		do {
			try notes.context?.save()
		} catch let error as NSError{
			print(error.localizedDescription)
		}
	}
    
	public func deleteNote(noteNumber: Int) {
		notes.deleteNote(index: noteNumber)
	}
}
