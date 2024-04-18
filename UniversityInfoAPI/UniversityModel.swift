//
//  UniversityModel.swift
//  UniversityInfoAPI
//
//  Created by user238111 on 4/17/24.
//

import Foundation

class UniversityModel : Decodable {
    var name : String
    var country : String
    var countryCode : String
    var province: String
    var webpages: [String]
    var domains: [String]
    
    init() {
        self.name = ""
        self.country = ""
        self.countryCode = ""
        self.province = ""
        self.webpages = []
        self.domains = []
    }
}
