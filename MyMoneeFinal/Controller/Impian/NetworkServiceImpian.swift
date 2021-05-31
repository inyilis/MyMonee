//
//  NetworkServiceImpian.swift
//  MyMoneeFinal
//
//  Created by MacBook on 21/05/21.
//

import Foundation
import UIKit

class NetworkServiceImpian{
    //    let apiKey: String = "99bc66d74f8686fc34d985741a078dc0"
    let url: String = "https://60a5e6cdc0c1fd00175f4a94.mockapi.io/api/v1/mydream"
    
    func loadImpianList(completion: @escaping (_ impian: [Impian]) -> ()) {
        let components = URLComponents(string: self.url)!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                
                let dataImpian = try! decoder.decode([Impian].self, from: data)
                completion(dataImpian)
            }
        }
        task.resume()
    }
    
    func addImpianList(uploadDataModel: Impian, completion: @escaping () -> ()) {
        let components = URLComponents(string: self.url)!
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            completion()
        }
        task.resume()
    }
    
    func updateImpianList(id: String, uploadDataModel: Impian, completion: @escaping () -> ()) {
        let components = URLComponents(string: "\(url)/\(id)")!
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            completion()
        }
        task.resume()
    }
    
    func delImpianList(id: String, completion: @escaping () -> ()) {
        let components = URLComponents(string: "\(url)/\(id)")!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            completion()
        }
        task.resume()
    }
    
}

var serviceImpian: NetworkServiceImpian = NetworkServiceImpian()
