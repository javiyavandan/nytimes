//
//  Artical.swift
//  NYTImes
//
//  Created by Vihaa on 6/18/19.
//  Copyright © 2019 VIHAA. All rights reserved.
//

import Foundation

class Article {
    
    var views: Int = 0
    var abstract: String = ""
    var url: String = ""
    var type: String = ""
    var title: String = ""
    var source: String = ""
    var section: String = ""
    var publishedDate: String = ""
    var id: Int64 = 0
    var byline: String = ""
    var adx_keywords: String = ""
    var media:[ArticleImages] = []
    
    init(jsonData: NSDictionary) {
        self.views = jsonData.getIntValue(key: APIKey.views)
        self.abstract = jsonData.getStringValue(key: APIKey.abstract)
        self.url = jsonData.getStringValue(key: APIKey.url)
        self.type = jsonData.getStringValue(key: APIKey.type)
        self.title = jsonData.getStringValue(key: APIKey.title)
        self.source = jsonData.getStringValue(key: APIKey.source)
        self.section = jsonData.getStringValue(key: APIKey.section)
        self.publishedDate = jsonData.getStringValue(key: APIKey.publishedDate)
        self.byline = jsonData.getStringValue(key: APIKey.byline)
        self.adx_keywords = jsonData.getStringValue(key: APIKey.adxKeywords)
        self.id = jsonData.getInt64Value(key: APIKey.id)
        
        let arrMedia = jsonData.getArrayValue(key: APIKey.media)
        
        for item in arrMedia {
            
            let mediaImages = (item as! NSDictionary).getArrayValue(key: APIKey.mediaMetadata)
            
            let strCaption = (item as! NSDictionary).getStringValue(key: APIKey.caption)
            let strCopyright = (item as! NSDictionary).getStringValue(key: APIKey.copyright)
            
            for objImage in mediaImages {
                
                self.media.append(ArticleImages(jsonData: (objImage as! NSDictionary), copyright: strCopyright, caption: strCaption))
            }
        }
    }
}

class ArticleImages {
    
    var url: String = ""
    var subtype: String = ""
    var copyright: String = ""
    var caption: String = ""
    
    init(jsonData: NSDictionary,copyright:String,caption:String) {
        self.copyright = copyright
        self.url = jsonData.getStringValue(key: APIKey.url)
        self.caption = caption
        
    }
}
