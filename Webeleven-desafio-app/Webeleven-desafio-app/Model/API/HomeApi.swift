//
//  HomeApi.swift
//  Webeleven-desafio-app
//
//  Created by School Picture on 14/04/2018.
//  Copyright © 2018 Gabriel Carvalho. All rights reserved.
//

import UIKit
import Foundation

open class HomeApi {
    
    open static let sharedInstace = HomeApi()
    
    lazy var dataSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 25
        config.timeoutIntervalForResource = ApiUtils.ApiConstants.TIME_OUT_INTERVAL_FOR_RESOURCE
        
        var delegate = DataRequestDelegate()
        
        var session = URLSession(configuration: config, delegate: delegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    open func getDefaultHomeScreen(callback: @escaping(_ homescreen: [HomeScreen]?, _ error: NSError?) -> Void) {
        var request = ApiUtils.sharedInstance.webserviceRequestBuilder("/search?term=pinkfloyd&entity=musicTrack")
        request.httpMethod = "GET"
        
        let task = dataSession.dataTask(with: request as URLRequest, completionHandler: {
            data, response, responseError in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    guard let json = data?.parseJsonData() else {
                        print("Failed to parse json")
                        callback(nil, NSError(domain: "webeleven", code: 0, userInfo: ["Generic Error": "0"]))
                        return
                    }
                    var home = [HomeScreen]()
                    if let resultsDictionary = json["results"] as? [NSDictionary] {
                        for r in resultsDictionary {
                            home.append(HomeScreen.init(artistName: r["artistName"] as? String,
                                                        collectionName: r["collectionName"] as? String,
                                                        trackName: r["trackName"] as? String,
                                                        artworkUrl100: r["artworkUrl100"] as? String,
                                                        collectionPrice: r["collectionPrice"] as? Double,
                                                        trackPrice: r["trackPrice"] as? Double,
                                                        primaryGenreName: r["primaryGenreName"] as? String,
                                                        kind: r["kind"] as? String))
                        }
                    }
                    callback(home, nil)
                default:
                    print("Failed to get default home screen")
                    callback(nil, NSError(domain: "webeleven", code: 0, userInfo: ["Generic Error": "0"]))
                }
            }
        })
        task.resume()
        
    }
    
    open func getHomeScreen(_ term: String, callback: @escaping(_ homescreen: [HomeScreen]?, _ error: NSError?) -> Void) {
        let termTrimmed = term.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)

        var request = ApiUtils.sharedInstance.webserviceRequestBuilder("/search?term=\(termTrimmed)&entity=musicTrack")
        request.httpMethod = "GET"
        
        let task = dataSession.dataTask(with: request as URLRequest, completionHandler: {
            data, response, responseError in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    guard let json = data?.parseJsonData() else {
                        print("Failed to parse json")
                        callback(nil, NSError(domain: "webeleven", code: 0, userInfo: ["Generic Error": "0"]))
                        return
                    }
                    var home = [HomeScreen]()
                    if let resultsDictionary = json["results"] as? [NSDictionary] {
                        for r in resultsDictionary {
                            home.append(HomeScreen.init(artistName: r["artistName"] as? String,
                                                        collectionName: r["collectionName"] as? String,
                                                        trackName: r["trackName"] as? String,
                                                        artworkUrl100: r["artworkUrl100"] as? String,
                                                        collectionPrice: r["collectionPrice"] as? Double,
                                                        trackPrice: r["trackPrice"] as? Double,
                                                        primaryGenreName: r["primaryGenreName"] as? String,
                                                        kind: r["kind"] as? String))
                        }
                    }
                    callback(home, nil)
                default:
                    callback(nil, NSError(domain: "webeleven", code: 0, userInfo: ["Generic Error": "0"]))
                }
            }
        })
        task.resume()
    }
    
}
