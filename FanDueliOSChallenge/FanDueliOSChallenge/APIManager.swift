//
//  APIManager.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/12/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit
import Alamofire

public class APIManager: NSObject {

    private override init() {}
 
    public static let sharedInstance: APIManager = APIManager()
    
    public func fetchJSON(completion: (Bool->())?) {
        Alamofire.request(.GET, "https://cdn.rawgit.com/liamjdouglas/bb40ee8721f1a9313c22c6ea0851a105/raw/6b6fc89d55ebe4d9b05c1469349af33651d7e7f1/Player.json", parameters: nil, encoding: .JSON, headers: nil)
            .responseJSON {
                response in
                switch response.result {
                case .Success(let data):
                    guard let players: [[String: AnyObject]] = data["players"] as? [[String: AnyObject]] else {
                        print("We encountered an error parsing basic json")
                        return
                    }
                    for player in players {
                        print(player)
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
}
