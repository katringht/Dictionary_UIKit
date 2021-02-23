//
//  ViewController.swift
//  Project7
//
//  Created by Ekaterina Tarasova on 21.02.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filterPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func alertCredits() {
        let ac = UIAlertController(title: "Data source", message: "These petitions come from the \nWe The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
    @objc func alertFilter() {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(title: "OK", style: .default) { [weak ac, self] _ in
            guard let keyword = ac?.textFields?[0].text else { return }
            self.filter(keyword)
        }
        
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    
    @objc func resetAction() {
        filterPetitions.removeAll()
        tableView.reloadData()
    }
    
    func filter(_ keyword: String) {
        for index in 0...petitions.count - 1{
            if petitions[index].title.lowercased().contains(keyword.lowercased()){
                filterPetitions.append(petitions[index])
            }
        }
        
        if filterPetitions.isEmpty{
            let ac = UIAlertController(title: "Empty filter", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterPetitions.isEmpty ? petitions.count : filterPetitions.count
    }
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return petitions.count
    //    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //        cell.textLabel?.text? = "Title goes here"
        //        cell.detailTextLabel?.text = "Subtitle goes here"
        let petition : Petition
        
        if filterPetitions.isEmpty {
            petition = petitions[indexPath.row]
        } else {
            petition = filterPetitions[indexPath.row]
        }
        
        cell.textLabel?.text? = petition.title.uppercased()
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



