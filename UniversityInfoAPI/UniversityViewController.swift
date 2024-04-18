//
//  UniversityViewController.swift
//  UniversityInfoAPI
//
//  Created by user238111 on 4/17/24.
//

import UIKit

class UniversityViewController: UIViewController,UniversityAPIDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var universityListLabel: UILabel!
    
    
    @IBOutlet weak var universityTableView: UITableView!
    
    var countryName :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UniversityAPIService.shared.universityAPIDelegate = self
        if let currentText = universityListLabel.text {
            universityListLabel.text = currentText + " " + countryName
        }
        UniversityAPIService.shared.getUniversities(countryName: countryName)
        universityTableView.reloadData()
    }
        
    
    
    func apiCallFinishWithListOfUniversities(universitiesList: [UniversityModel]) {
        appDelegate?.universitiesList = universitiesList
        universityTableView.reloadData()
    }

    func apiCallDidFinishWithError() {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (appDelegate?.universitiesList.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "univcell", for: indexPath)
        cell.textLabel?.text = appDelegate?.universitiesList[indexPath.row].name
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? UniversityInfoViewController,
           let selectedIndexPath = universityTableView.indexPathForSelectedRow
            {
                let universityObj = appDelegate?.universitiesList[selectedIndexPath.row]
                destinationVC.universityObject = universityObj!
            }
        }

}
