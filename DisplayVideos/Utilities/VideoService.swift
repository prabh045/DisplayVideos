//
//  VideoService.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 17/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation
import os.log

class VideoService {
    
    static func fetchVideos(completion: @escaping ([VideoModel]?, Error?) -> Void) {
        let urlString = "https://interview-e18de.firebaseio.com/media.json?print=pretty"
        guard let url = URL(string: urlString) else {
            completion(nil,nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                os_log(.debug, log: .default, "Error Fetching data from server")
                return
            }
            
            guard let data = data else {
                os_log(.debug, log: .default, "No Data available")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                os_log(.debug, log: .default, "No Response")
                return
            }
            
            guard response.statusCode == 200 else {
                os_log(.debug, log: .default, "Wrong Status Code")
                return
            }
            //let stringData = String(data: data, encoding: .utf8)
            do {
                let dataModel = try JSONDecoder().decode([VideoModel].self, from: data)
                completion(dataModel,nil)
            } catch let err{
                completion(nil,err)
                os_log(.info, log: .default, "Error in converting Data")
            }
            
        }.resume()
    }
    
    
}


