//
//  ViewController.swift
//  Project7
//
//  Created by Андрей Гавриков on 05.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filtered = [Petition]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(weThePeople))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(filterPetitions))

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc
    func filterPetitions() {
        let ac = UIAlertController(title: "Filter", message: "write a filter word", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self, weak ac]_ in
            if let text = ac?.textFields?.first?.text, let petitions = self?.petitions {
                if text == "" {
                    self?.filtered = petitions
                } else {
                    self?.filtered = petitions.filter{ $0.body.contains(text)}
                }
                self?.tableView.reloadData()
            }
        }))
        present(ac, animated: true)
    }
    
    @objc
    func weThePeople() {
        let message = "bal blalsd balds"
        let ac = UIAlertController(title: "We The People API", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filtered = petitions
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filtered[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filtered[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

