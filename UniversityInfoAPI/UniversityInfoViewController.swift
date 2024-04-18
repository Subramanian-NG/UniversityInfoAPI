//
//  UniversityInfoViewController.swift
//  UniversityInfoAPI
//
//  Created by user238111 on 4/17/24.
//

import UIKit

class UniversityInfoViewController: UIViewController {
    
    var universityObject : UniversityModel = UniversityModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = universityObject.name
        country.text = universityObject.country
        province.text = universityObject.province
        let webpagesString = universityObject.webpages.joined(separator: ", ")
        website.text = webpagesString

    }
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var country: UILabel!
    
    
    @IBOutlet weak var province: UILabel!
    
    
    @IBOutlet weak var website: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
