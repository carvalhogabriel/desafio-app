//
//  HomeScreen.swift
//  Webeleven-desafio-app
//
//  Created by School Picture on 14/04/2018.
//  Copyright © 2018 Gabriel Carvalho. All rights reserved.
//

import Foundation

open class HomeScreen: Codable {
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: String
    var collectionPrice: Double
    var trackPrice: Double
    var primaryGenreName: String
    var kind: String
    
    init(artistName: String?,
         collectionName: String?,
         trackName: String?,
         artworkUrl100: String?,
         collectionPrice: Double?,
         trackPrice: Double?,
         primaryGenreName: String?,
         kind: String?) {
        self.artistName = artistName ?? ""
        self.collectionName = collectionName ?? ""
        self.trackName = trackName ?? ""
        self.artworkUrl100 = artworkUrl100 ?? ""
        self.collectionPrice = collectionPrice ?? 0
        self.trackPrice = trackPrice ?? 0
        self.primaryGenreName = primaryGenreName ?? ""
        self.kind = kind ?? ""
    }
}
