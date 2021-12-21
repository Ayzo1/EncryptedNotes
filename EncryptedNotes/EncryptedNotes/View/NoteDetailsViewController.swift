import UIKit

class NoteDetailsViewController: UIViewController, UITextViewDelegate {
    
    public var presenter: PresenterProtocol!
	public var noteID: Int = -1
    
    private lazy var headerTextView: UITextView = {
        let textView = UITextView()
        view.addSubview(textView)
        textView.frame.size.width = textView.superview?.frame.size.width ?? 200
        textView.frame.size.height = 200
        textView.center = CGPoint(x: textView.superview?.center.x ?? 100, y: 100)
        textView.backgroundColor = .systemGray6
        textView.font = .systemFont(ofSize: 40, weight: .bold)
        return textView
    }()
    
    private lazy var generalTextView: UITextView = {
        let textView = UITextView()
        view.addSubview(textView)
        textView.frame.size.width = textView.superview?.frame.size.width ?? 200
        textView.frame.size.height = (textView.superview?.frame.size.height ?? 600) - 200
        textView.center = CGPoint(x: textView.superview?.center.x ?? 100, y: (textView.superview?.center.y  ?? 700) + 100)
        
        textView.font = .systemFont(ofSize: 25)
        return textView
    }()
    
    public var header: String = ""
    public var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        headerTextView.delegate = self
        generalTextView.delegate = self
        headerTextView.text = header
        generalTextView.text = text
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    
	@objc public func save () {
		header = headerTextView.text
		text = generalTextView.text
		print(" details: " + header)
		if noteID == -1 {
			presenter.saveNewNote(header: header, text: text)
		}
		else {
			presenter.changeNote(noteNumber: noteID, header: header, text: text)
		}
		navigationController?.popToRootViewController(animated: true)
	}
	
}
