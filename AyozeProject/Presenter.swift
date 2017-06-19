//
//  Presenter.swift
//  AyozeProject
//
//  Created by Loquat Solutions on 18/6/17.
//  Copyright © 2017 MHP. All rights reserved.
//

import Foundation


class Presenter {


    func callService ( urlString : String, httpMethod: String , data: Data , completion: @escaping (_ result: [String:AnyObject]) -> Void)
    {
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        // Set the method to POST
        request.httpMethod = httpMethod
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let data3 = "idPersona=3501590&idDispositivo=ABC&estado=1".data(using: .utf8)
        // Set the POST/put body for the request
        request.httpBody = data3
        request.addValue("no-cache", forHTTPHeaderField: "cache-control")
        request.setValue(String.init(format: "%i", (data.count)), forHTTPHeaderField: "Content-Length")
        print ("printrequest")
        print(request)
        
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
                    print(self.convertStringToDictionary(text: utf8Text)! as! [String : AnyObject])
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
    
    func  ayofun(text: String) -> String {
        if text == "hola " {
      
         return "si";
        }
    return "no";
    
    }

}
