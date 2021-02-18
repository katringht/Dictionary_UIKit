//
//  ViewController.swift
//  Project4
//
//  Created by Ekaterina Tarasova on 14.02.2021.
//

import UIKit

class ViewController: UITableViewController{

    var websites = ["apple.com", "github.com"]
    var websiteToLoad: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My sites"
        navigationController?.navigationBar.prefersLargeTitles = true
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sites", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MySites") as?
            SitesViewController{
            vc.websiteToLoad = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

