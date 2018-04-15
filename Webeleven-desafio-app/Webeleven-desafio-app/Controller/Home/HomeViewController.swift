//
//  ViewController.swift
//  Webeleven-desafio-app
//
//  Created by School Picture on 14/04/2018.
//  Copyright © 2018 Gabriel Carvalho. All rights reserved.
//

import UIKit
import STXImageCache
import DZNEmptyDataSet

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // MARK: - @IBOutLets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Private Vars
    private var homescreen: [HomeScreen]!
    private var collectionHomescreen: [HomeScreen]!
    private var searchActive : Bool = false
    private var searchArray : [HomeScreen]?
    private var searchFiltered : [HomeScreen] = []
    private var navigateToHomeDetail: HomeScreen!
    
    // MARK: - Private Methods
    private func buildAlertError(_ title: String, message: String) {
        let errorAlert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    private func buildLoadingAlert() {
        let loadingAlert = UIAlertController(title: "", message: "\n\n\n\n\n", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loadingAlert.view.addSubview(indicator)
        indicator.center = CGPoint(x: 130.5, y: 65.5)
        indicator.startAnimating()
        indicator.color = UIColor.black
        indicator.isUserInteractionEnabled = false
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    private func getDefaultCollectionView() {
        self.buildLoadingAlert()
        HomeApi.sharedInstace.getDefaultHomeScreen {
            (homescreen, error) in
            if (error != nil) {
                self.buildAlertError((error?.code.description)!, message: error.debugDescription)
            } else {
                self.collectionHomescreen = homescreen
                self.collectionView.reloadData()
            }
        }
    }
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.prepareDZNEmptyDataSource()
        self.getDefaultCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - SearchBar Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.buildLoadingAlert()
        HomeApi.sharedInstace.getHomeScreen(self.searchBar.text!, callback: {
            (homescreen, error) in
            if error != nil {
                self.buildAlertError((error?.code.description)!, message: error.debugDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
                self.homescreen = homescreen
                self.tableView.reloadData()
            }
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchArray != nil {
            self.searchFiltered = self.searchArray!.filter({ (text) -> Bool in
                let homescreen: HomeScreen = text
                let tmp = homescreen.artistName as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if (self.searchFiltered.count == 0) {
                self.searchActive = false;
            } else {
                self.searchActive = true;
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDelegate/Datasource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.homescreen != nil {
            return self.homescreen.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (homescreen.count > 0) {
            self.navigateToHomeDetail = self.homescreen[indexPath.item]
            self.performSegue(withIdentifier: "HomeDetail", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "HomeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HomeTableViewCell else {
            assertionFailure("Failed to load UITableViewCell")
            return UITableViewCell()
        }
        
        cell.tableViewImage.stx.image(atURL: URL(string: self.homescreen[indexPath.item].artworkUrl100)!)
        cell.tableViewTitle.text = self.homescreen[indexPath.item].collectionName
        cell.tableViewSubTitle.text  = self.homescreen[indexPath.item].trackName
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let dvc as HomeDetailViewController:
            dvc.homeDetail = self.navigateToHomeDetail
            self.navigateToHomeDetail = nil
        default: break
        }
    }
    
    // MARK: - DZNEmptyDataSetSource/Delegate methods
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "NoSearchResults")!
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.lightGray
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Sem Resultados")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Nada foi pesquisado")
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func prepareDZNEmptyDataSource(){
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDatasource
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.collectionHomescreen != nil {
            return self.collectionHomescreen.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "HomeCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            assertionFailure("Failed to load UICollectionViewCell")
            return UICollectionViewCell()
        }
        
        cell.collectionImage.stx.image(atURL: URL(string: self.collectionHomescreen[indexPath.item].artworkUrl100)!)
        cell.collectionTitle.text = self.collectionHomescreen[indexPath.item].collectionName
        cell.collectionSubTitle.text  = self.collectionHomescreen[indexPath.item].trackName
        
        return cell
    }
}
