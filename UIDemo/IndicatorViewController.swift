//
//  IndicatorViewController.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/2/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class IndicatorViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var indicatorList: UICollectionView!
    @IBOutlet weak var listHeight: NSLayoutConstraint!
    @IBOutlet weak var illustrateList: UICollectionView!
    private var titles = [String]()
    private lazy var spinIndicator:SpinIndicator = {
        return SpinIndicator(center: CGPoint(x: UIScreen.main.bounds.width/2-10,
                                             y: 116))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI Related Methods
    func configureUIElements(){
        let backImg = IonIcons.image(withIcon: ion_android_arrow_back,
                                     iconColor: UIColor.black,
                                     iconSize: 30,
                                     imageSize: CGSize(width: 30, height: 30))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImg,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(back))
        listHeight.constant = UIScreen.main.bounds.height/2
        automaticallyAdjustsScrollViewInsets = false
        titles = ["Spinning Indicator", "Breath Indicator", "Dots Indicator", "Escaping Indicator", "Bouncing Indicator", "Blink Indicator"]
    }
    
    func back() {
        navigationController!.popViewController(animated: true)
    }
    
    //MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == indicatorList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
            if indexPath.item == 0 {
                DispatchQueue.main.async {
                    cell.containerView.addSubview(self.spinIndicator)
                    if cell.containerView.subviews.count>=2 {
                        let dummyView = cell.containerView.subviews[cell.containerView.subviews.count-2]
                        dummyView.removeFromSuperview()
                    }
                    self.spinIndicator.show()
                }
            }else if indexPath.item == 1 {
                DispatchQueue.main.async {
                    let breathIndicator = BreathIndicator(radius: 50,
                                                            color: UIColor.lightGray,
                                                            center: CGPoint(x: UIScreen.main.bounds.width/2-10,
                                                                            y: 116))
                    cell.containerView.addSubview(breathIndicator)
                    if cell.containerView.subviews.count>=2 {
                        if let dummyView = cell.containerView.subviews[cell.containerView.subviews.count-2] as? BreathIndicator {
                            dummyView.stopAnimation()
                        }else {
                            cell.containerView.subviews[cell.containerView.subviews.count-2].removeFromSuperview()
                        }
                    }
                    breathIndicator.show()
                }
            }else if indexPath.item == 2{
                DispatchQueue.main.async {
                    //Default color is green, but you can change color by uncommenting following line
                    //dots.dotColor = UIColor.red
                    let dotsIndicator = DotsIndicator(dotWidth: 20, center: CGPoint(x: UIScreen.main.bounds.width/2-10,
                                                                                    y: 116))
                    cell.containerView.addSubview(dotsIndicator)
                    if cell.containerView.subviews.count>=2 {
                        if let dummyView = cell.containerView.subviews[cell.containerView.subviews.count-2] as? DotsIndicator {
                            dummyView.stopAnimation()
                        }else {
                            cell.containerView.subviews[cell.containerView.subviews.count-2].removeFromSuperview()
                        }
                    }
                    dotsIndicator.show()
                }
            }else if indexPath.item == 3{
                let bounce = EscapingIndicator(radius: 40, center: CGPoint(x: UIScreen.main.bounds.width/2-10,
                                                                           y: 116))
                cell.containerView.addSubview(bounce)
                if cell.containerView.subviews.count>=2 {
                    if let dummyView = cell.containerView.subviews[cell.containerView.subviews.count-2] as? EscapingIndicator {
                        dummyView.stopAnimation()
                    }else {
                        cell.containerView.subviews[cell.containerView.subviews.count-2].removeFromSuperview()
                    }
                }
                bounce.show()
            }else if indexPath.item == 4 {
                let bounce = BouncingIndicator(radius: 40, center: CGPoint(x: UIScreen.main.bounds.width/2-10,
                                                                           y: 116))
                cell.containerView.addSubview(bounce)
                if cell.containerView.subviews.count>=2 {
                    if let dummyView = cell.containerView.subviews[cell.containerView.subviews.count-2] as? BouncingIndicator {
                        dummyView.stopAnimation()
                    }else {
                        cell.containerView.subviews[cell.containerView.subviews.count-2].removeFromSuperview()
                    }
                }
                bounce.show()
            }else if indexPath.item == 5 {
                let blink = BlinkIndicator(dotWidth: 40, center: CGPoint(x: UIScreen.main.bounds.width/2-10,
                                                                         y: 116))
                cell.containerView.addSubview(blink)
                if cell.containerView.subviews.count>=2 {
                    if let dummyView = cell.containerView.subviews[cell.containerView.subviews.count-2] as? BlinkIndicator {
                        dummyView.stopAnimation()
                    }else {
                        cell.containerView.subviews[cell.containerView.subviews.count-2].removeFromSuperview()
                    }
                }
                blink.show()
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemoCell", for: indexPath) as! DemoCollectionViewCell
            cell.titleLabel.text = titles[indexPath.item]
            return cell
        }
    }
    
    //MARK: UICollectionDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == indicatorList {
            illustrateList.contentOffset = scrollView.contentOffset
        }else if scrollView == illustrateList {
            indicatorList.contentOffset = scrollView.contentOffset
        }
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == indicatorList {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2-100)
        }else {
            return illustrateList.frame.size
        }
    }
}
