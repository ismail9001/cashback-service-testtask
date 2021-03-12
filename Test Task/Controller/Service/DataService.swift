//
//  DataService.swift
//  Test Task
//
//  Created by macbook on 10.02.2021.
//

import Alamofire
import SwiftyJSON

class DataService {
    
    private lazy var repository = Repository()
    let baseUrl = Config.apiUrl
    
    func getData(oldData: [TestData]){
        
        let path = "/photos"
        let parameters: Parameters = [:]
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            guard let data = response.data else {return}
            do {
                let json = try JSON(data: data)
                self.repository.deleteData(oldData)
                self.repository.addData(json: json)
            } catch {
                print (error)
            }
        }
    }
}

