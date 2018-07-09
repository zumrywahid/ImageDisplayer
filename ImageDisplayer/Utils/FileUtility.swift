//
//  FileUtility.swift
//  ImageDisplayer
//
//  Created by Zumry Gapstars on 7/8/18.

import Foundation


import UIKit

public class FileUtility {
    
    static var IMAGE_PATH = "ImageFolder"
    
    static func saveImage(data: Data?, fileName: String) {
        do {
            guard let data = data else {
                return
            }
            
            let fileManager = FileManager.default
            
            let imageDirectory = try getDocumentPath().appendingPathComponent( self.IMAGE_PATH, isDirectory: true)
            
            if !fileManager.fileExists(atPath: imageDirectory.path) {
                try fileManager.createDirectory(at: imageDirectory as URL, withIntermediateDirectories: true, attributes: nil)
            }
            let filePath = imageDirectory.appendingPathComponent(fileName).path
            
            fileManager.createFile(atPath: filePath, contents: data as Data, attributes: nil)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func retrieveImage(fileName: String) -> UIImage? {
        var image: UIImage?
        do {
            let fileManager = FileManager.default
            
            let imageDirectory = try getDocumentPath().appendingPathComponent( self.IMAGE_PATH, isDirectory: true)
            
            let imageUrl = imageDirectory.appendingPathComponent(fileName)
            
            if fileManager.fileExists(atPath: imageUrl.path) {
                image = UIImage(contentsOfFile: imageUrl.path)
            }
            
            print("retrieve image url is \(imageUrl.path)")
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
    
    static func deleteImage (fileName: String) {
        do {
            let fileManager = FileManager.default
            
            let imageDirectory = try getDocumentPath().appendingPathComponent( self.IMAGE_PATH, isDirectory: true)

            let imageUrl = imageDirectory.appendingPathComponent(fileName)
            
            if fileManager.fileExists(atPath: imageUrl.path) {
                try fileManager.removeItem(at: imageUrl)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    static func getDocumentPath()throws -> URL {
        
        let fileManager = FileManager.default
        let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectory
    }
    
}
