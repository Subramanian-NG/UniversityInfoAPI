//
//  ViewController.swift
//  UniversityInfoAPI
//
//  Created by user238111 on 4/17/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CountryAPIDelegate {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    

    @IBOutlet weak var searchbar: UISearchBar!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CountryAPIService.shared.countryAPIDelegate = self
        searchbar.delegate = self
    }
    
    func apiCallFinishWithListOfCountries(list: [String]) {
        appDelegate?.countryList = list
        tableView.reloadData()
    }
    
    func apiCallDidFinishWithError() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (appDelegate?.countryList.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = appDelegate?.countryList[indexPath.row]
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count > 2 {
            // Networking Service with Delegate Protocol
            CountryAPIService.shared.getListOfCountries(searchText: searchText)
        }
        if searchText.count == 0 {
            appDelegate?.countryList = []
            tableView.reloadData()
        }
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UniversityViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow
        {
            let countryName = appDelegate?.countryList[selectedIndexPath.row]
            destinationVC.countryName = countryName!
        }
    }
    
}

