//
//  ImageDisplayerTests.swift
//  ImageDisplayerTests
//
//  Created by Zumry Gapstars on 7/8/18.


import XCTest
@testable import ImageDisplayer

class ImageDisplayerTests: XCTestCase {
    
    var apiManager: ApiManager?
    
    override func setUp() {
        super.setUp()
        apiManager = ApiManager()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFlickerUrl() {
        //to test async type we need expectation object
        let expect = expectation(description: "Testing flickr data")
        
        apiManager?.downloadFlickrData(completionHandler: { response in
            
            print("Result  is \(response)")
            
            assert((response != nil), "Image list is null")
            
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: {Void in
            print("Flickr data test completed...")
        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
