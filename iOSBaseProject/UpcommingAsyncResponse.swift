//
//  UpcommingAsyncResponse.swift
//  iOSBaseProject
//
//  Created by Jorge Mendoza on 3/17/16.
//  Copyright © 2016 Codefuel. All rights reserved.
//

import UIKit

class UpcommingAsyncResponse: NSObject, HttpManagerDelegate {
    
    var datasource:AnyObject?
    
    func fillDataSource(result: NetworkRequestResult) {
        switch(result){
        case .Empty:
            self.datasource = []
        case .Failure(let error):
            print("Error retrieving matchlist: ", error.description)
            self.datasource = []
        case .Success(let res):
            self.datasource = res["data"].rawValue
            print("The datasource:", self.datasource)
        }
    }
}
