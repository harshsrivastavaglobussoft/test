//
//  dataModel.swift
//  DropDownMenu
//
//  Created by Sumit Ghosh on 05/12/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class dataModel: NSObject {
    func dataForMenu() -> Any {
        do {
            if let file = Bundle.main.url(forResource: "filterresponse", withExtension: "json"){
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    print(object)
                    return object
                } else if let object = json as? [Any] {
                    print(object)
                    return object
                } else {
                    print("JSON is invalid")
                    return 0
                }
            } else {
                print("no file")
                return 0
            }
        } catch {
            print(error.localizedDescription)
            return error.localizedDescription
        }
        return 0
   }
}
