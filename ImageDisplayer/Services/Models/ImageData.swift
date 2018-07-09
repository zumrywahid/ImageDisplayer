//
//  ImageData.swift
//  ImageDisplayer
//
// This is going to be a model object and its going to be saved in coredata..
//
import Foundation
import UIKit

public class ImageData {
    var photoId: String?
    var farmId: String?
    var serverId: String?
    var secretId: String?
    var fileName: String?
    var image : UIImage?
    //settiing up the url using  above parameters.
    var imageUrl: String {
        return "https://farm\(farmId!).staticflickr.com/\(serverId!)/\(photoId!)_\(secretId!).jpg"
    }

}
