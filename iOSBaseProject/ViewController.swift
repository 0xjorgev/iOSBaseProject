//
//  ViewController.swift
//  iOSBaseProject
//
//  Created by Jorge Mendoza on 3/16/16.
//  Copyright © 2016 Codefuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callApiRequest()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func callApiRequest() {
        
        let http:HttpHandler = HttpHandler()
        let req:requestParameters = requestParameters(url:ApiUrl.COMPETITIONBYID, urlParam:"1", body:nil, header: nil)
        http.customGETRequest(req)
        
        let res = UpcommingAsyncResponse()
        http.delegate = res
    }
}

