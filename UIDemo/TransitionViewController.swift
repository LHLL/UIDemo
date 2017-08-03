//
//  TransitionViewController.swift
//  UIDemo
//
//  Created by Xu, Jay on 2/21/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet weak var musicTable: UITableView!
    @IBOutlet weak var musicCollection: UICollectionView!
    @IBOutlet weak var flow: UICollectionViewFlowLayout!
    
    let grip = IonIcons.image(withIcon: ion_grid,
                              iconColor: UIColor.white,
                              iconSize: 30,
                              imageSize: CGSize(width: 30, height: 30))
    
    let hanburg = IonIcons.image(withIcon: ion_navicon_round,
                                 iconColor: UIColor.white,
                                 iconSize: 30,
                                 imageSize: CGSize(width: 30, height: 30))
    
    fileprivate var movies = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                if self.musicTable.isHidden == false {
                    self.musicTable.reloadData()
                }else {
                    self.musicCollection.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: hanburg,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(meiShaoNvBianShen))
        
        automaticallyAdjustsScrollViewInsets = false
        musicTable.register(UINib(nibName: "MusicTableViewCell", bundle: nil),
                            forCellReuseIdentifier: "musicCell")
        musicTable.estimatedRowHeight = 200
        musicTable.rowHeight = UITableViewAutomaticDimension
        musicCollection.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: "MovieCell")
        musicTable.isHidden = true
        
//        WebServiceHandler().getTopMovies { (result) in
//            switch result {
//            case .success(let data):
//                self.movies = data
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    @objc private func meiShaoNvBianShen(sender:UIBarButtonItem){
        var views = [UIView]()
        var frames = [CGRect]()
        
        if sender.image == grip {
            if musicTable.contentOffset.y > 0 && musicTable.isDecelerating {
                musicTable.setContentOffset(musicTable.contentOffset, animated: false)
            }
            sender.image = hanburg
            
            var indexes = musicTable.indexPathsForVisibleRows
            indexes!.sort(by: {$0<$1})
            musicCollection.scrollToItem(at:IndexPath(item: indexes!.first!.row, section: 0), at: .top, animated: false)
            musicCollection.layoutIfNeeded()
            
            var collectionIndexes = musicCollection.indexPathsForVisibleItems
            collectionIndexes.sort(by: {$0<$1})
            collectionIndexes = collectionIndexes.filter({$0.item>=indexes!.first!.row})
            
            for index in (0..<musicTable.visibleCells.count) {
                let cell = self.musicTable.cellForRow(at: indexes![index]) as! MusicTableViewCell
                let temp = self.extractSnapshotFromView(originView: cell)
                temp.frame = self.musicTable.convert(cell.frame, to: self.view)
                self.view.addSubview(temp)
                views.append(temp)
                
                let movie = self.musicCollection.cellForItem(at:collectionIndexes[index]) as! MovieCollectionViewCell
                frames.append(self.musicCollection.convert(movie.frame, to: self.view))
            }
            
            musicCollection.isHidden = false
            
            for cell in self.musicCollection.visibleCells {
                cell.alpha = 0
            }
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                for index in (0..<views.count) {
                    views[index].frame = CGRect(origin: frames[index].origin,
                                                size: CGSize(width: (UIScreen.main.bounds.width-36)/3, height: 200))
                    
                    views[index].alpha = 0
                }
                for cell in self.musicTable.visibleCells {
                    cell.alpha = 0
                }
            }, completion: { (success) in
                for cell in self.musicCollection.visibleCells {
                    cell.alpha = 1
                }
                for v in views {
                    v.removeFromSuperview()
                }
                views.removeAll()
                frames.removeAll()
                self.musicTable.isHidden = true
            })
        }else {
            if musicCollection.contentOffset.y > 0 && musicCollection.isDecelerating {
                musicCollection.setContentOffset(musicCollection.contentOffset, animated: true)
            }
            sender.image = grip
            musicTable.reloadData()
            var indexes = musicCollection.indexPathsForVisibleItems
            indexes.sort(by: {$0<$1})
            musicTable.scrollToRow(at: indexes.first!, at: .top, animated: true)
            
            for index in (0..<musicTable.visibleCells.count) {
                let cell = musicCollection.cellForItem(at: IndexPath(item: indexes[index].item, section: 0)) as! MovieCollectionViewCell
                let temp = extractSnapshotFromView(originView: cell)
                temp.frame = musicCollection.convert(cell.frame, to: view)
                view.addSubview(temp)
                cell.isHidden = true
                views.append(temp)
                
                let music = musicTable.visibleCells[index] as! MusicTableViewCell
                frames.append(musicTable.convert(music.frame, to: view))
            }
            
            musicTable.isHidden = false
            for cell in musicTable.visibleCells {
                cell.alpha = 0
            }
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                for index in (0..<views.count) {
                    views[index].frame = CGRect(origin: frames[index].origin,
                                                size: CGSize(width:70,height:100))
                    
                    views[index].alpha = 0
                }
                for cell in self.musicCollection.visibleCells {
                    cell.alpha = 0
                    if self.musicCollection.indexPath(for: cell)!.item >= views.count {
                        cell.frame = CGRect(origin: CGPoint(x: cell.frame.origin.x,
                                                            y: cell.frame.origin.y*2),
                                            size: cell.frame.size)
                    }
                }
            }, completion: { (success) in
                DispatchQueue.main.async {
                    self.musicCollection.isHidden = true
                    for cell in self.musicTable.visibleCells {
                        cell.alpha = 1
                    }
                    
                    for cell in self.musicCollection.visibleCells {
                        cell.isHidden = false
                        cell.alpha = 1
                    }
                    for v in views {
                        v.removeFromSuperview()
                    }
                    views.removeAll()
                    frames.removeAll()
                    self.musicCollection.reloadData()
                }
            })
            
        }
    }
    
    func extractSnapshotFromView(originView:UIView) -> UIView {
        
        UIGraphicsBeginImageContextWithOptions(originView.bounds.size, false, 0)
        originView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshot = UIImageView(image: snapshotImage)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TransitionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicTableViewCell
        cell.updateUI(movies[indexPath.row])
        return cell
    }
}

extension TransitionViewController:UITableViewDelegate {
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == musicTable {
//            var indexes = musicTable.indexPathsForVisibleRows
//            indexes!.sort(by: {$0<$1})
//            musicCollection.scrollToItem(at:indexes!.first!, at: .top, animated: false)
//        }
//    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        var rotation = CATransform3D()
//        rotation = CATransform3DMakeRotation( -CGFloat((90.0*M_PI)/180.0), 0.0, 0.7, 0.4);
//        rotation.m34 = -1.0/600
//        
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width:10, height:10)
//        cell.alpha = 0
//        cell.layer.transform = rotation
//        cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
//        UIView.beginAnimations("rotation", context: nil)
//        UIView.setAnimationDuration(0.8)
//        cell.layer.transform = CATransform3DIdentity
//        cell.alpha = 1
//        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//        UIView.commitAnimations()
//    }
}

extension TransitionViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        cell.configureUI(movie: movies[indexPath.item])
        cell.isHidden = false
        cell.alpha = 1
        return cell
    }
}

extension TransitionViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width-36)/3, height: 200)
    }
}
