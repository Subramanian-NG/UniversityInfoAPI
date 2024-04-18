//
//  CountryAPIService.swift
//  UniversityInfoAPI
//
//  Created by user238111 on 4/17/24.
//	

import Foundation


protocol CountryAPIDelegate {
    func apiCallFinishWithListOfCountries(list: [String]);
    func apiCallDidFinishWithError();
}



class CountryAPIService {
    
    static var shared = CountryAPIService()
    
    var countryAPIDelegate: CountryAPIDelegate?

    func getListOfCountries		(searchText: String){
        let urlObj = URL(string: "https://restcountries.com/v2/name/"+searchText+"?fields=name")!
        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            
            if error != nil {
                self.countryAPIDelegate?.apiCallDidFinishWithError()
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                       (200...299).contains(httpResponse.statusCode) else {
                        self.countryAPIDelegate?.apiCallDidFinishWithError()
                        return
                   }
            // Check if data is available
            guard let data = data else {
                print("No data received")
                return
            }
                
            do {
                
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var listOfCountries = [String]()
                    for country in jsonArray {
                        if let name = country["name"] as? String {
                            print(name)
                            listOfCountries.append(name)
                        }
                    }
                    DispatchQueue.main.async {
                        self.countryAPIDelegate?.apiCallFinishWithListOfCountries(list: listOfCountries)
                    }
                                        
                } else {
                    print("Invalid JSON format")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    
    
    
    
    
    
}
