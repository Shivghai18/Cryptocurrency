//
//  Downloader.swift
//  YahooAPI
//
//  Created by Rania Arbash on 2020-03-13.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import Foundation


class Downloader {
    
    var results : Double! = nil
    
    func download(text: String)  {
        
        let url = URL(string: "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC\(text)")!

        var request = URLRequest(url: url)

        request.setValue("MjVhNjE0MmY1OGEwNDQyZDkyYTAwOTM3Y2U5ZGI3ZDY", forHTTPHeaderField: "x-ba-key")

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    
                return
            }
            if let mimeType = httpResponse.mimeType,
                let data = data
                 {
               
                do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    
                    self.results	  =  jsonObject.value(forKeyPath: "ask") as? Double
                }catch{
                    
                }
                
                DispatchQueue.main.async {
                    // send notification
                    NotificationCenter.default.post(name: Notification.Name("WepAPIIsReady"), object: nil)
                    
                    }
            }
        }
        
        task.resume()
        
    }
    
}
