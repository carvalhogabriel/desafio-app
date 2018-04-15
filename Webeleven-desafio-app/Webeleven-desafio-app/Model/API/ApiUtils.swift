//
//  ApiUtils.swift
//  Webeleven-desafio-app
//
//  Created by School Picture on 14/04/2018.
//  Copyright © 2018 Gabriel Carvalho. All rights reserved.
//

import UIKit

public class ApiUtils {
    public struct ApiConstants {
        static let API_URL = "https://itunes.apple.com"
        static let TIME_OUT_INTERVAL_FOR_RESOURCE: TimeInterval = 300
    }
    
    static let sharedInstance = ApiUtils()
    
    func webserviceRequestBuilder(_ servicePath: String) -> URLRequest {
        let url = URL(string: ApiConstants.API_URL + servicePath)
        let request = URLRequest(url: url!)
        return request
    }
}

extension Data {
    func parseJsonData() -> NSDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: self, options:[]) as? NSDictionary
        } catch {
            print("Failed to parse json from response with error \(error)")
            return nil
        }
    }
    
    func parseJsonArrayData() -> [NSDictionary]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options:[]) as? [NSDictionary]
        } catch {
            print("Failed to parse json from response with error \(error)")
            return nil
        }
    }
}
