import Foundation
import CoreData
import UIKit
final class Notes {
    
    // MARK: - Properties
    
    private var appDelegate: AppDelegate!
    public var context: NSManagedObjectContext!
    public var notes = [Note]()
    
    init () {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate.persistentContainer.viewContext
		
		let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
		do {
			notes = try context?.fetch(fetchRequest) as! [Note]
		} catch let error as NSError {
			print(error.localizedDescription)
		}
		
    }
    
    public func count () -> Int {
        return notes.count
    }
    
    public func addNote (header: String, text: String) {
        let description = NSEntityDescription.entity(forEntityName: "Note", in: context!)!
		let note = NSManagedObject(entity: description, insertInto: context) as! Note
        note.setValue(header, forKey: "header")
        note.setValue(text, forKey: "text")
        notes.append(note)
		let n = note
		print("h:  " + n.header! + "   " + header)
		
        do {
            try context?.save()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    public func deleteNote ( index: Int ) {
		let note = notes[index]
		context?.delete(note as NSManagedObject)
		do {
			try context?.save()
		} catch let error as NSError{
			print(error.localizedDescription)
		}
        notes.remove(at: index)
    }
	
	public func deleteNote() {
		let note = notes[0]
		context?.delete(note as NSManagedObject)
		do {
			try context?.save()
		} catch let error as NSError{
			print(error.localizedDescription)
		}
		notes.remove(at: 0)
	}
    
    /*
    public func getNote ( index: Int) -> Note {
        return notes[index]
    }
    
    public func changeNote (index: Int, header: String, text: String) {
        notes[index].header = header
        notes[index].text = text
    }
     */
}
