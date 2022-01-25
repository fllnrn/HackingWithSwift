//
//  ViewController.swift
//  Project33
//
//  Created by Андрей Гавриков on 24.01.2022.
//

import UIKit
import CloudKit

class ViewController: UITableViewController {
    static var isDirty = true
    
    var whistles = [Whistle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "What's that Whistle?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @objc
    func addWhistle() {
        let vc = RecordWhistleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if ViewController.isDirty {
            loadWhistles()
        }
    }
    func loadWhistles() {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Whistles", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["genre", "coments"]
        operation.resultsLimit = 50
        var newWhistles = [Whistle]()
        
        operation.recordFetchedBlock = {record in
            let whistle = Whistle()
            whistle.recordID = record.recordID
            whistle.genre = record["genre"]
            whistle.comments = record["comments"]
            newWhistles.append(whistle)
        }
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ViewController.isDirty = false
                    self.whistles = newWhistles
                    self.tableView.reloadData()
                } else {
                    let ac = UIAlertController(title: "Fetch failed", message: "Problem", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
            
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.attributedText = makeAttributedString(title: whistles[indexPath.row].genre, subtitle: whistles[indexPath.row].comments)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)

        if subtitle.count > 0 {
            let subtitleString = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleString.append(subtitleString)
        }

        return titleString
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResultsViewController()
        vc.whistle = whistles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

