//
//  HomeViewController.swift
//  NYTImes
//
//  Created by Vihaa on 6/18/19.
//  Copyright © 2019 VIHAA. All rights reserved.
//

import UIKit

//MARK:- Enums to filter data for Articles for specific periods
enum days:String {
    case ONE  = "1"
    case SEVEN  = "7"
    case THIRTY = "30"
}

class HomeViewController: UIViewController {

    //Local Veriable declarations
    @IBOutlet weak var tblArticles: UITableView!
    var period:String = days.ONE.rawValue
    var articalesArray:Array<Article> = Array()
    var filteredarticalesArray = [Article]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpIntialViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //API CALL to fetch latest articales
        self.setWebApiCallToGetallAllArticles()
    }
    
    
    //Start User Defined Funcations
    
    /// Funcations to set intial property for views and subviews.
    ///
    /// - returns: void
    //Created By Vandan Javiya
    //Created Date : 19-06-2019
    
    func setUpIntialViews(){
        
        self.navigationItem.title = "NY Times Most Popular"
        
        //Set header Navigation Search Bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchController.searchBar.tintColor = .white
        definesPresentationContext = true
        
        //Tableview Properties
        self.tblArticles.tableFooterView = UIView.init()
        self.tblArticles.estimatedRowHeight = 70
        
        //Set Navigation Item buttons
        var barItems = [UIBarButtonItem]()
        
        guard let imgMore = UIImage(named: "more") else {
            return
        }
        let rightBtnMore = UIBarButtonItem(image: imgMore.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.moreTapped))
        barItems.append(rightBtnMore)
        guard let img = UIImage(named: "search") else {
            return
        }
        let rightBtn = UIBarButtonItem(image: img.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.searchTapped))
        barItems.append(rightBtn)
        
       
        
        if barItems.count == 0 {
            navigationItem.hidesBackButton = true
        }
        navigationItem.rightBarButtonItems = barItems
        
        guard let imgMenu = UIImage(named: "menu") else {
            return
        }
        let leftMenuBtn = UIBarButtonItem(image: imgMenu.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.menuTapped))
        
        if barItems.count == 0 {
            navigationItem.hidesBackButton = true
        }
        self.navigationItem.rightBarButtonItems = barItems
        self.navigationItem.leftBarButtonItem = leftMenuBtn
    }
    
    //End User Defined Funcations

    //Start Button Click Events
    //Drawer Menu button clicks
    @objc fileprivate func menuTapped() {
        appDelegate.toggelDrawerMenu()
    }
    
    //Drawer More button clicks to filter data for specific periods
    @objc fileprivate func moreTapped() {
        
        let alert = UIAlertController(title: "", message: "Select Period", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "1 day", style: .default , handler:{ (UIAlertAction)in
            self.period = days.ONE.rawValue
            self.setWebApiCallToGetallAllArticles()
        }))
        
        alert.addAction(UIAlertAction(title: "7 days", style: .default , handler:{ (UIAlertAction)in
            self.period = days.SEVEN.rawValue
            self.setWebApiCallToGetallAllArticles()
        }))
        
        alert.addAction(UIAlertAction(title: "30 days", style: .default , handler:{ (UIAlertAction)in
            self.period = days.THIRTY.rawValue
            self.setWebApiCallToGetallAllArticles()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Cancel button")
        }))
        
        alert.view.tintColor = ThemeColors.colorPrimaryLightGreen
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    //Drawer Search button clicks
    @objc fileprivate func searchTapped() {
        if(isFiltering() == false)
        {
            tblArticles.setContentOffset(CGPoint.init(x: CGPoint.zero.x, y: CGPoint.zero.y - 40), animated: false)
        }
    }
    
    //MARK : Start WEB API CALLS
    
    /// Funcations to call api for article data fetching
    ///
    /// - returns: void
    //Created By Vandan Javiya
    //Created Date : 19-06-2019
    
    func setWebApiCallToGetallAllArticles(){
        
        let requestUrl = APITAG.viewed + period + ".json"
        
        API.sharedInstance.getAllArticales(requestUrl) { (status, json) in
            if(status)
            {
                let arrResults = json![APIKey.results] as! NSArray
                
                self.articalesArray.removeAll()
                for obj in arrResults {
                    self.articalesArray.append(Article(jsonData: obj as! NSDictionary))
                }
                self.tblArticles.reloadData()
            }
            else
            {
                
            }
        }
    }
    
    //End  WEB API CALLS

}

//Search Update
extension HomeViewController:UISearchResultsUpdating {
    
    //Search Bar datasource and filtering data methods
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredarticalesArray = articalesArray.filter({( article : Article) -> Bool in
            return article.title.lowercased().contains(searchText.lowercased())
        })
        
        tblArticles.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

//MARK:- table datasource/delegate
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.articalesArray.count
        
        if isFiltering() {
            return filteredarticalesArray.count
        }
        
        return articalesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleCell
        cell.selectionStyle = .none
        
        //let objArticle = self.articalesArray[indexPath.row]
        
        let objArticle: Article
        if isFiltering() {
            objArticle = self.filteredarticalesArray[indexPath.row]
        } else {
            objArticle = self.articalesArray[indexPath.row]
        }
        
        cell.lblTitle.text = objArticle.title
        cell.lblPublishedBy.text = objArticle.byline
        cell.lblDate.text = objArticle.publishedDate
        
        cell.viewImage.setCornerRadiusForView(Int(cell.viewImage.frame.size.height/2))
        cell.viewImage.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objArticle: Article
        if isFiltering() {
            objArticle = filteredarticalesArray[indexPath.row]
        } else {
            objArticle = articalesArray[indexPath.row]
        }
        
        let objDetailsVC = UIStoryboard.main.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
        objDetailsVC.objArticles = objArticle
        self.navigationController?.pushViewController(objDetailsVC, animated: true)
       
    }
}
