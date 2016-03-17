//
//  HttpHandler.swift
//  iOSBaseProject
//
//  Created by Jorge Mendoza on 3/16/16.
//  Copyright © 2016 Codefuel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum NetworkRequestResult {
    case Success(JSON) //response JSON
    case Empty
    case Failure(NSError)
}

protocol HttpManagerDelegate {
    func fillDataSource(result:NetworkRequestResult)
}

enum HTTPMethod: String {
    case POST, GET
}

struct requestParameters {
    let url:ApiUrl
    let urlParam:String?
    let body:[String:AnyObject]?
    let header:[String : String]?
}

enum ApiUrl:String {
    //Add your own!
    case BASE = "https://somosportpocdev.herokuapp.com/api/v1.0"
    case HOME = "index.php"
    case COMPETITION = "competition"
    case COMPETITIONBYID = "competition/{:id}"
}

class HttpHandler: NSObject {
    
    var delegate:HttpManagerDelegate?
    //This is redundant
    func urlBuilder(apiService:ApiUrl, urlParam:String?) -> String {
        
        switch(urlParam){
            case .None:
//                print("\(ApiUrl.BASE.rawValue)/\(apiService.rawValue)/")
                return "\(ApiUrl.BASE.rawValue)/\(apiService.rawValue)/"
            case .Some(let param):
//                print("\(ApiUrl.BASE.rawValue)/\(apiService.rawValue.stringByReplacingOccurrencesOfString("{:id}", withString: param))/")
                return "\(ApiUrl.BASE.rawValue)/\(apiService.rawValue.stringByReplacingOccurrencesOfString("{:id}", withString: param))/"
            
        }
    }
    
    //TODO:
    //Add check for status code, Emtptyness, etc
    
    func customPOSTRequest(parameters: requestParameters) {
        Alamofire.request(.POST, urlBuilder(parameters.url, urlParam: parameters.urlParam), parameters: parameters.body, encoding: .JSON, headers: parameters.header)
            .responseJSON{
            response in
                print("Response JSON: \(response.result.value)")
                self.delegate?.fillDataSource(.Success(JSON(response.result.value!)))
        }
    }
    
    func customGETRequest(parameters: requestParameters) {
        Alamofire.request(.GET, urlBuilder(parameters.url, urlParam: parameters.urlParam), parameters: parameters.body, encoding: .JSON, headers: parameters.header)
            .responseJSON{
                response in
                print("Response JSON: \(response.result.value)")
                self.delegate?.fillDataSource(.Success(JSON(response.result.value!)))

        }
    }
    
}
