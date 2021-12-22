import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var header: String?
    @NSManaged public var text: String?
    @NSManaged public var isEncrypted: Bool

}

extension Note : Identifiable {

}
