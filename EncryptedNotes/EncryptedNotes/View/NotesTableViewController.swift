import UIKit

class NotesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Viewable {
    
    private var presenter: PresenterProtocol!
    
    private lazy var table: UITableView = {
        let table = UITableView()
        view.addSubview(table)
        table.frame.size = table.superview?.frame.size ?? .init(width: 200, height: 200)
        table.center = table.superview?.center ?? CGPoint(x: 150, y: 150)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter(notesTableView: self, notes: Notes())
        table.dataSource = self
        table.delegate = self
        print (table.superview?.frame.size.height ?? 0)
        print (table.frame.size.height)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
    }
    
    @objc func addButtonAction () {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let noteDetails = storyboard.instantiateViewController(identifier: "NoteDetailsViewController") as! NoteDetailsViewController
        noteDetails.presenter = presenter
        navigationController?.pushViewController(noteDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNotesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
		let a = presenter.getNoteHeader(noteNumber: indexPath.row)
		print("header: " + a)
        cell.textLabel?.text = presenter.getNoteHeader(noteNumber: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let noteDetails = storyboard.instantiateViewController(identifier: "NoteDetailsViewController") as! NoteDetailsViewController
        navigationController?.pushViewController(noteDetails, animated: true)
        table.deselectRow(at: indexPath, animated: true)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		table.reloadData()
	}
}
