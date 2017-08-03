//
//  CardViewController.swift
//  UIDemo
//
//  Created by Xu, Jay on 1/23/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var cardDetailCollection: UICollectionView!
    
    fileprivate let cardImgs = [UIImage(named:"creditCard"),UIImage(named:"wf"),UIImage(named:"creditCard")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "ImageCell")
        cardDetailCollection.register(UINib(nibName: "CardDetailCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "CardDetailCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CardViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cardImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CardCollectionViewCell
            //cell.cardImg.image = cardImgs[indexPath.row]
            if indexPath.item != 0 {
                //cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            cell.tag = indexPath.item
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardDetailCell", for: indexPath) as! CardDetailCollectionViewCell
            return cell
        }
        
    }
}

extension CardViewController:UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = false
        let visibleCells = cardCollectionView.visibleCells
        for cell in visibleCells {
            print(scrollView.contentSize)
            if cell == visibleCells.last {
                //cell.transform = CGAffineTransform(scaleX: 1-0.2*scrollView.contentOffset.x/scrollView.frame.size.width, y: 1-0.2*scrollView.contentOffset.x/scrollView.frame.size.width)
            }else {
                //cell.transform = CGAffineTransform(scaleX: 1+0.25*scrollView.contentOffset.x/scrollView.frame.size.width, y: 1+0.25*scrollView.contentOffset.x/scrollView.frame.size.width)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = true
//        let visibleCells = cardCollectionView.visibleCells
//        for cell in visibleCells {
//            if view.convert(cell.frame, to: view).contains(CGPoint(x: cardCollectionView.frame.width/2, y: 200)) {
//                print(cell.tag)
//            }
//        }
        
    }
}

extension CardViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*8/10, height: 200)
    }
}

extension CardViewController {
    func transformCard(cell:UICollectionViewCell){
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
}
