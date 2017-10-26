//
//  AppDelegate.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let accessKey = getAccessKey()
        let network = NetworkHttpService(baseUrl: "http://em.wemakesites.net", secretKey: accessKey)
        let tableViewController = getRootController()
        tableViewController.presenter = BandSearchPresenter(network: network, storage: LastResultStorage(), view: tableViewController)

        return true
    }

    func getRootController() -> BandSearchController {
        guard let navController = window?.rootViewController as? UINavigationController,
            let tableViewController = navController.viewControllers.first as? BandSearchController else {
                fatalError("Root controllers has wrong type")
        }

        return tableViewController
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
        if endpointKey.isEmpty {
            print("warning - empty key!!!")
        }

        return endpointKey
    }

}
