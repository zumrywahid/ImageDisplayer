//
//  ApiManager.swift
//  ImageDisplayer
//
//  Created by Zumry Gapstars on 7/8/18.


import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import Alamofire_SwiftyJSON

public class ApiManager {
    
    //TODO later we can change the url according to our need
    static var BASE_URL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2ab4f053690eb704517e7412159032c2&text=apple&per_page=15&page=&format=json&nojsoncallback=1&api_sig=a631c0b2f1226874f6d0f23270a089f4"
    
    var headers = ["Content-Type":"application/json"]
    
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        return Alamofire.SessionManager(configuration: configuration)
    }()

    func downloadFlickrData(completionHandler: @escaping ((_ result: [ImageData]?)-> Void)) {
        
        manager.request(ApiManager.BASE_URL, method: HTTPMethod.post, encoding: JSONEncoding.default, headers: headers).responseSwiftyJSON(completionHandler: { response in
            
            if let status = response.response?.statusCode {
                if status != 200 {
                    completionHandler(nil)
                    return
                }
            }
            
            if let JSON = response.value {
                
                let jsonArray = JSON["photos"]["photo"]
                
                var imageArray = [ImageData]()
                
                for (_, value): (String, JSON) in jsonArray {
                    let imageData = ImageData()
                    imageData.photoId = value["id"].string
                    imageData.farmId = "\((value["farm"].int)!)"
                    imageData.serverId = value["server"].string
                    imageData.secretId = value["secret"].string
                    
                    imageArray.append(imageData)
                }
                
                completionHandler(imageArray)
            }
            
            
        })
    }
    
    
}
