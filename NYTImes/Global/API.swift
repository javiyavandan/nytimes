import UIKit

//MARK : This class is used to call api funcations, api keys, api messages and tags
//Class also creates singleton instance

let API_MOST_POPULAR = "/mostpopular/"


struct APITAG {
    
    static let viewed    = "/viewed/"
    
}

struct APIKey {
    static let caption   =   "caption"
    static let copyright   =   "copyright"
    static let subtype   =   "subtype"
    
    static let abstract   =   "abstract"
    static let results   =   "results"
    static let adxKeywords   =   "adx_keywords"
    static let assetId   =   "asset_id"
    static let byline   =   "byline"
    static let id   =   "id"
    static let media   =   "media"
    static let mediaMetadata   =   "media-metadata"
    
    static let publishedDate   =   "published_date"
    static let section   =   "section"
    static let source   =   "source"
    static let title   =   "title"
    static let type   =   "type"
    static let url   =   "url"
    static let views   =   "views"
}


enum APIRESPONSESTATUS:String {
    case OK  = "OK"
}


class API: NSObject {
    
    struct Singleton {
        static let sharedInstance = API()
    }
    
    class var sharedInstance: API {
        return Singleton.sharedInstance
    }
    
    typealias completionHandler = ((Bool,AnyObject?)->Void)?
    
    fileprivate func displayError(_ error:NSError!,needDismiss:Bool = false){
    
    if error != nil {
        if error.code == -1009 || error.code == -1001{
            Functions.displayAlert(APPERRORMESSAGES.noNetwork,needDismiss: needDismiss);
        }
        else if error.code == -6003
        {
            
        }
        else{
            Functions.displayAlert(APPERRORMESSAGES.serverError,needDismiss: needDismiss)
        }
    }
}
    
    
    //Web APi Call
    //MARK: ---- Get All Articales  ----- HOMEVC
    
    func getAllArticales(_ strApiParameters:String?,block:completionHandler){
        
        Functions.apiGetCall(API_MOST_POPULAR + API_VERSION + strApiParameters!, block: { (json, error) -> Void in
            
            if error != nil {
                self.displayError(error, needDismiss: false)
                block?(false,nil)
            }else{
                
                if (((json?["status"] as? String) ?? "").lowercased() != APIRESPONSESTATUS.OK.rawValue.lowercased()) {
                    
                    Functions.displayToast(APPERRORMESSAGES.serverError)
                    block?(false,json as AnyObject)
                }
                else
                {
                    block?(true,json as AnyObject)
                }
            }
        })
    
    }
    
}
