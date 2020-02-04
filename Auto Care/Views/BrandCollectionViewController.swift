//
//  BrandCollectionViewController.swift
//  Auto Care
//
//  Created by Kilz on 29/01/2020.
//  Copyright © 2020 Kilz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

//private let reuseIdentifier = "Cell"

class BrandCollectionViewController: UICollectionViewController {
    
    
    //MARK: VAR
    var BrandArray: [Brand] = []
    var brand: Brand?
    
    
    //NVAIndicator
    var activityIndicator: NVActivityIndicatorView?
    
    
    //Customizing Brand Cell
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    private let brandsPerRow: CGFloat = 3
    
    
    
    //Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.width / 2 - 30, width: 80, height: 80), type: .circleStrokeSpin, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), padding: nil)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadBrands()
    }
    
        //Mark: Loading Indicator
    
    //show indicator
    private func showLoadingindicator() {
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    
    
    //hide indicator
    
    private func hideLoadIndicator() {
        
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
    
                            //MARK:  - FUNCTIONS
    
    //Download Brands
    
    private func downloadBrands(){
        downloadBrandFromDatabase { (allBrands) in
            print("Brands are", allBrands.count)
            self.BrandArray = allBrands
            self.collectionView.reloadData()
        }
    }

    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
         return BrandArray.count
        
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCollectionViewCell
    
        cell.generateBrandCell(BrandArray[indexPath.row])
    
        return cell
    }
    
    

     // MARK: UICollectionViewDelegate
    
    //moving to Category
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "brandToCategorySegue", sender: BrandArray[indexPath.row])
       // print("Brand selected is:",brand?.brandName)
    }
    
    
    
    // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "brandToCategorySegue" {
               let VC = segue.destination as! CategoryCollectionViewController
            VC.brand = sender as! Brand
           }
       }


}

extension BrandCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (brandsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / brandsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    
}
