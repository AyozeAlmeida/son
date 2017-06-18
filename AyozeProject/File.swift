//
//  File.swift
//  AyozeProject
//
//  Created by Loquat Solutions on 17/6/17.
//  Copyright © 2017 MHP. All rights reserved.
//

import Foundation

class File {


func callService ( urlString : String, httpMethod: String , data: Data , completion: @escaping (_ result: [String:AnyObject]) -> Void)
{
    
    let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
    // Set the method to POST
    request.httpMethod = httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Set the POST/put body for the request
    request.httpBody = data
    request.setValue(String.init(format: "%i", (data.count)), forHTTPHeaderField: "Content-Length")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        if data == nil
        {
            var errorResponse = [String : AnyObject]()
            errorResponse["Error"] = "Issue" as AnyObject?
            completion(errorResponse)
        }
        else
        {
            if  let utf8Text = String(data: data! , encoding: .utf8) {
                completion(self.convertStringToDictionary(text: utf8Text)! as! [String : AnyObject])
            }
            else
            {
                var errorResponse = [String : AnyObject]()
                errorResponse["Error"] = "Issue" as AnyObject?
                completion(errorResponse)
            }
        }
    })
    task.resume()
}

func convertStringToDictionary(text: String) -> NSDictionary? {
    if let data = text.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary as! [String : AnyObject]? as NSDictionary?
        } catch let error as NSError {
            var errorResponse = [String : AnyObject]()
            errorResponse["Error"] = "Issue" as AnyObject?
            print(error)
            return errorResponse as NSDictionary?
        }
    }
    return nil
}


}
    
