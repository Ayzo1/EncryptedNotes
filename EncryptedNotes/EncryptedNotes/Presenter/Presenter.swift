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
		let note = notes.notes[noteNumber] as? Note
		return note?.header ?? "ff"
    }
	
	public func saveNewNote (header: String, text: String) {
		notes.addNote(header: header, text: text)
	}
    
}
