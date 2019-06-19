//
//  ArticleDetailsViewController.swift
//  NYTImes
//
//  Created by Vihaa on 6/19/19.
//  Copyright © 2019 VIHAA. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    //View Outlet Declarations
    @IBOutlet weak var lblKeywords: UILabel!
    @IBOutlet weak var lblPublishedDate: UILabel!
    @IBOutlet weak var lblViews: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var imageCollectionview: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //Local Declarations
    var arrImages:Array<ArticleImages> = Array()
    var objArticles:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setIntialsViews()
        // Do any additional setup after loading the view.
    }
    
    /// Funcations to set intial properties of views and subeviews
    ///
    /// - returns: void
    //Created By Vandan Javiya
    //Created Date : 19-06-2019
    func setIntialsViews(){
        
        self.navigationItem.title = "Article Details"
        
        //Set Data
        self.setArticaleDetailsData()
    }
    
    /// Funcations to set article details data for views
    ///
    /// - returns: void
    //Created By Vandan Javiya
    //Created Date : 19-06-2019
    
    func setArticaleDetailsData(){
        
        self.lblTitle.text = self.objArticles?.title ?? ""
        self.lblAuthor.text = self.objArticles?.byline ?? ""
        self.lblPublishedDate.text = self.objArticles?.publishedDate ?? ""
        self.lblKeywords.text = self.objArticles?.adx_keywords ?? ""
        self.lblViews.text = self.objArticles?.views.toString()
        
        self.arrImages = (self.objArticles?.media)!
        
        DispatchQueue.main.async {
            self.imageCollectionview.reloadData()
           
        }
    }
   
}

//CollectionView datasource/delegate methods
extension ArticleDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell
        
        let objImage = self.arrImages[indexPath.item]
        cell?.mediaImage.setImageWithPlaceholder(string: objImage.url)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.size.width - 40), height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
