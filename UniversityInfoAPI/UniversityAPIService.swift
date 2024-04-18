//
//  UniversityAPIService.swift
//  UniversityInfoAPI
//
//  Created by user238111 on 4/17/24.
//

import Foundation

protocol UniversityAPIDelegate {
    func apiCallFinishWithListOfUniversities(universitiesList: [UniversityModel]);
    func apiCallDidFinishWithError();
}


class UniversityAPIService {
    
    static var shared = UniversityAPIService()
    
    var universityAPIDelegate: UniversityAPIDelegate?
    
    
    func getUniversities(countryName: String) {
        let url = "http://universities.hipolabs.com/search?country=\(countryName)"
        guard let urlObj = URL(string: url) else {
            self.universityAPIDelegate?.apiCallDidFinishWithError()
            return
        }

        URLSession.shared.dataTask(with: urlObj) { data, response, error in
            if error != nil {
                self.universityAPIDelegate?.apiCallDidFinishWithError()
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) else {
                self.universityAPIDelegate?.apiCallDidFinishWithError()
                return
           }

            guard let data = data else {
                self.universityAPIDelegate?.apiCallDidFinishWithError()
                return
            }

            do {
                
                guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                    print("Error: Unable to convert data to JSON object")
                    self.universityAPIDelegate?.apiCallDidFinishWithError()
                    return
                }
                var universities = [UniversityModel]()
                for jsonDict in jsonObject {
                    
//                    guard let name = jsonDict["name"] as? String,
//                        let country = jsonDict["country"] as? String,
//                        let province = jsonDict["state-province"] as? String,
//                        let website = jsonDict["web_pages"] as? [String]
//                    else {
//                        print("Error: Unable to extract data from JSON object")
//                        self.universityAPIDelegate?.apiCallDidFinishWithError()
//                        return
//                    }
                    let name = jsonDict["name"] as? String ?? ""
                    let country = jsonDict["country"] as? String ?? ""
                    let province = jsonDict["state-province"] as? String ?? ""
                    let website = jsonDict["web_pages"] as? [String] ?? []

                    
                    let university = UniversityModel()
                    university.name = name
                    university.country = country
                    university.province = province
                    university.webpages = website
                    universities.append(university)
                }
                
                DispatchQueue.main.async {
                    self.universityAPIDelegate?.apiCallFinishWithListOfUniversities(universitiesList: universities)
                }

            } catch {
                self.universityAPIDelegate?.apiCallDidFinishWithError()
            }
        }.resume()
    }

         
    
}
