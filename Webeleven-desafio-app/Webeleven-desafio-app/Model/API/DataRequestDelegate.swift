//
//  DataRequestDelegate.swift
//  Webeleven-desafio-app
//
//  Created by School Picture on 14/04/2018.
//  Copyright © 2018 Gabriel Carvalho. All rights reserved.
//

import Foundation
class DataRequestDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("\(challenge.debugDescription)")
        print("\(String(describing: challenge.error))")
        print("\(String(describing: challenge.failureResponse))")
        print("\(String(describing: challenge.proposedCredential))")
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
    }
    
//    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
//        switch response.statusCode {
//        case 401:
//            TokenRefresher.sharedInstance.refreshUserToken(){
//                if $0 {
//                    guard let accessString = KeychainService.sharedInstance.accessToken else {
//                        print("Failed to retrieve access Token")
//                        return
//                    }
//
//                    let newRequest = (task.currentRequest! as NSURLRequest).mutableCopy() as! NSMutableURLRequest
//                    newRequest.setValue("Bearer \(accessString)", forHTTPHeaderField: "Authenticate")
//                    completionHandler(newRequest as URLRequest)
//                } else {
//                    completionHandler(request)
//                }
//            }
//        default: completionHandler(request)
//        }
//    }
//
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        print("Challenge Received")
//        completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
//    }
    
}
