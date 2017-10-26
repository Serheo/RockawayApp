//
//  ViewController.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var network: NetworkService!

    override func viewDidLoad() {
        super.viewDidLoad()
        let accessKey = getAccessKey()
        network = NetworkHttpService(baseUrl: "http://em.wemakesites.net", secretKey: accessKey)

        network.getBandSearchRequest(query: "Rock", successful: { (result) in
            print(result)
        }) { (err) in
            print(err)
        }

        network.getBandProfile(itemId: "186", successful: { (result) in
            print(result)
        }) { (err) in
            print(err)
        }
    }

    func getAccessKey() -> String {
        guard let path = Bundle.main.path(forResource: "AccessKeys", ofType: "plist") else {
            fatalError("Can't find AccessKeys.plist")
        }
        let url: URL = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String],
            let endpointKey = plist?["endpointKey"] else {
                fatalError("Please update AccessKeys.plist and add endpointKey into it")
        }

        return endpointKey
    }

}
