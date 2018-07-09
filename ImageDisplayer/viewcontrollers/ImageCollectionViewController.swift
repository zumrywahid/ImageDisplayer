//
//  ImageCollectionControllerCollectionViewController.swift
//  ImageDisplayer
//
//  Created by Zumry Gapstars on 7/8/18.
//

import UIKit

private let reuseIdentifier = "image_cell"

class ImageCollectionViewController: UICollectionViewController {

    var presenter:ImagePresenter?
    
    var imageList = [ImageData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Register cell classes
//        self.collectionView!.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        presenter = ImagePresenter(view: self)
        presenter?.loadImageData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        do {
            //Zumry:- 9/july/2018  Officially not recommened way to load image
            let imageData = imageList[indexPath.row]
            let url = URL(string: imageData.imageUrl)
            let data = try Data(contentsOf: url!)
           
            cell.imageView.image = UIImage(data:data)
        } catch {
            print(error.localizedDescription)
        }
        
        return cell
    }

}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var totalWidth: CGFloat = collectionView.frame.size.width
        let paddingOneSide: CGFloat = 5.0
        totalWidth = totalWidth - CGFloat(paddingOneSide * 4)
        
        return CGSize(width: CGFloat(totalWidth/2), height: CGFloat(totalWidth/2))
    }
    
}

extension ImageCollectionViewController: ImagePageView {
    func startLoading() {
        self.view.showLoading()
    }
    
    func finishLoading() {
        self.view.hideLoading()
    }
    
    func showImages(_ imageData: [ImageData]) {
        self.imageList = imageData
        self.collectionView?.reloadData()
    }
    
    
}
