//
//  NetworkService.swift
//  Navigation
//
//  Created by Максим Донских on 09.01.2023.
//

import Foundation

struct NetworkService {
    
    enum AppConfiguration {
        case first(url: String = "https://swapi.dev/api/people/8")
        case second(url: URL = URL(string: "https://swapi.dev/api/starships/3")!)
        case third(url: String = "https://swapi.dev/api/planets/5")
    }
    
    
    var urlArray: [AppConfiguration] = [
        .first(),
        .second(),
        .third()
    ]
    
    static func request(for configuration: AppConfiguration, completion: ((_ answer: String?, _ errorText: String?, _ statusCode: Int?, _ allHeaderFields: [AnyHashable : Any]?) -> Void)? ) {
        print(configuration)
        var url: URL?
        switch configuration {
        case .first("https://swapi.dev/api/people/8"):
            url = URL(string: "https://swapi.dev/api/people/8")
        case .second(URL(string: "https://swapi.dev/api/starships/3")!):
            url = URL(string: "https://swapi.dev/api/starships/3")
        case .third("https://swapi.dev/api/planets/5"):
            url = URL(string: "https://swapi.dev/api/planets/5")
        default:
            url = nil
            print("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, responce, error in
            if let error {
                completion?(nil, error.localizedDescription, nil, nil)
                print("Print -", error.localizedDescription)
                return
            }
            
            let statusCode = (responce as? HTTPURLResponse)?.statusCode
            let allHeaderFields = (responce as? HTTPURLResponse)?.allHeaderFields
            
            if statusCode != 200 {
                print("Print - Status code != 200, Status code = \(statusCode)")
                completion?(nil, "Status code != 200, Status code = \(statusCode)", nil, nil)
            } else {
                print("Print - Status code == \(statusCode)")
                print("Print - allHeaderFields: \(allHeaderFields)")
                completion?(nil, nil, statusCode, allHeaderFields)
            }
            
            guard let data else {
                print("Print - data =", data)
                completion?(nil, "data == nil", statusCode, allHeaderFields)
                return
            }
            
            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
                    answer.map {
                        let result = "Value: \($0) - Key: \($1)"
                        completion?(result, nil, nil, nil)
                        print("Print - Value: \($0) - Key: \($1)")
                    }
                }
            } catch {
                print("Print -", error.localizedDescription)
                completion?(nil, error.localizedDescription, statusCode, allHeaderFields)
            }
        }
        task.resume()
    }
}
