//
//  SpotifyViewController.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/7/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class SpotifyViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fakeNavigationBar: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if currentStyle == .lightContent{
            currentStyle = .default
            return .default
        }else {
            currentStyle = .lightContent
            return .lightContent
        }
    }
    private var currentStyle = UIStatusBarStyle.lightContent
    private var statusFlag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.register(UINib(nibName: "AlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AlbumCell")
        navigationController?.isNavigationBarHidden = true
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UICollectionViewDelegate and UICollectionDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath as IndexPath) as! AlbumCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 231)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath)
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 165)
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateImageView()
        fakeNavigationBar.alpha = (scrollView.contentOffset.y-134)/66 + 0.4
        titleLabel.alpha = (134-scrollView.contentOffset.y)/66 + 0.4
        if fakeNavigationBar.alpha > 0.6 && statusFlag {
            statusFlag = false
            setNeedsStatusBarAppearanceUpdate()
        }else if fakeNavigationBar.alpha < 0.6 && statusFlag == false {
            statusFlag = true
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateImageView()
    }
    
    //MARK:Utility method
    func updateImageView(){
        let cell = myCollectionView.cellForItem(at: NSIndexPath(item: 0, section: 0) as IndexPath)
        if (cell != nil) {
            let cellRect = cell!.frame as CGRect
            let position = myCollectionView.convert(cellRect, to: view)
            height.constant = position.origin.y
        }
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }

}

