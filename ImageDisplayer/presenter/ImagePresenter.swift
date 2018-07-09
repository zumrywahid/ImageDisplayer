//
//  ImagePresenter.swift
//  ImageDisplayer
//
//  Created by Zumry Gapstars on 7/9/18.

import Foundation

protocol ImagePageView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func showImages(_ imageData: [ImageData])
}

public class ImagePresenter {
    
    init(view: ImagePageView) {
        self.imagePageView = view
    }
    
    fileprivate var apimanager = ApiManager()
    
    weak fileprivate var imagePageView : ImagePageView?
    
    func loadImageData() {
        self.imagePageView?.startLoading()
        apimanager.downloadFlickrData(completionHandler: { response in
            
            if let imageList: [ImageData] = response {
                self.imagePageView?.showImages(imageList)
            } else {
                self.imagePageView?.showImages([ImageData]()) //loading empty set
            }
            
            self.imagePageView?.finishLoading()
        })
    }
    
}
