//
//  DetailViewController.swift
//  Project38
//
//  Created by Андрей Гавриков on 29.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailLabel: UILabel!
    
    var detailItem: Commit?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detail = self.detailItem {
            detailLabel.text = detail.message
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Commit 1/\(detail.author.commits.count) by \(detail.author.name)", style: .plain, target: self, action: #selector(showAuthorCommits))
        }
    }
    
    @objc
    func showAuthorCommits() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tableView") as! ViewController
        let authorName = detailItem!.author.name
        vc.commitPredicate = NSPredicate(format: "author.name == %@", authorName as NSString)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
