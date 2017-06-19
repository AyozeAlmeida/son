//
//  ViewController.swift
//  AyozeProject
//
//  Created by Loquat Solutions on 17/6/17.
//  Copyright © 2017 MHP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        let urlString2 = "http://www.loquatsolutions.com/detres/detres/api/pruebaAyo"
        let urlString = "http://192.168.208.130:3000/getDatos"
        var data = Data()
        do{
            let finalDict  = NSMutableDictionary()
            // finalDict.setValue(infoValue, forKey: "info")
            
            finalDict.setValue("ABC", forKey: "idPersona")
            finalDict.setValue("3340CF08-2A4C-47F4-A360-3FA75561F7A2", forKey: "idDispositivo")
            finalDict.setValue("1", forKey: "estado")
            
            
            let newdata = try JSONSerialization.data(withJSONObject:finalDict , options: [])
            let newdataString = String(data: newdata, encoding: String.Encoding.utf8)!
            print(newdataString)
            
            data = newdataString.data(using: .utf8)!
            
            let another =     try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary as! [String : AnyObject]? as NSDictionary?
            print(another!)
            
        }
        catch let error as NSError {
            print(error)
        }
        
        let presenter = Presenter()
        
        presenter.callService(urlString: urlString, httpMethod: "POST", data: data) {
            (response) in
            let mainData = response["meta"] as! NSDictionary
            var code = Int()
            code = mainData["code"]  as! Int
            if code != 200
            {
                var errorResponse = [String : AnyObject]()
                errorResponse["Error"] = "Issue" as AnyObject?
                //completion(errorResponse)
            }
            else
            {
                 print("Se ejecuto bien")
                //completion(response)
            }
        }
        
        print(presenter.ayofun(text: "hola "));
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    

}

