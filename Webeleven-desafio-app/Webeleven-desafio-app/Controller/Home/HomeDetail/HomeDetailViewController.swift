//
//  HomeDetailViewController.swift
//  Webeleven-desafio-app
//
//  Created by School Picture on 15/04/2018.
//  Copyright © 2018 Gabriel Carvalho. All rights reserved.
//

import Foundation
import UIKit

class HomeDetailViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var typeAlbum: UILabel!
    @IBOutlet weak var genreAlbum: UILabel!
    @IBOutlet weak var priceAlbum: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    @IBOutlet weak var downButton: UIImageView!
    
    @IBAction func swipeDownAction(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buyClick(_ sender: Any) {
        let buyAlert = UIAlertController(title: "Em desenvolvimento" , message: "Ainda estamos desenvolvendo este módulo", preferredStyle: .alert)
        buyAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(buyAlert, animated: true, completion: nil)
    }
    
    // MARK: - Public Vars
    var homeDetail: HomeScreen!
    
    // MARK: - Private Methods
    private func prepareView() {
        self.albumImage.stx.image(atURL: URL(string: self.homeDetail.artworkUrl100)!)
        self.albumName.text = self.homeDetail.collectionName
        self.artistName.text = self.homeDetail.artistName
        self.typeAlbum.text = self.homeDetail.kind
        self.genreAlbum.text = self.homeDetail.primaryGenreName
        self.priceAlbum.text = "R$ \(String(format:"%.1f", self.homeDetail.trackPrice))"
        self.downButton.tintColor = UIColor(red: 177/255, green: 0/255, blue: 23/255, alpha: 1.0)
        self.buyButton.layer.borderColor = UIColor(red: 177/255, green: 0/255, blue: 23/255, alpha: 1.0).cgColor
        self.buyButton.layer.borderWidth = 1
        self.buyButton.layer.cornerRadius = 5
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
