//
//  ViewController.swift
//  ChainPageCollectionViewDemo
//
//  Created by yansong li on 2017-07-23.
//  Copyright © 2017 yansong li. All rights reserved.
//

import UIKit
import ChainPageCollectionView

class ViewController: UIViewController {
  
  let parentDataSource = ["yelp", "facebook", "netflix", "yahoo", "google", "indeed", "ritual",
                          "sina", "new york time", "firefox", "gilt"]
  
  let childDataSouce = [["Yelp has some news 1", "Yelp has some news 2", "Yelp has some news 3", "Yelp has some news 4", "Yelp has some news 5", "Yelp has some news 6"],
                        ["Facebook has some news 1", "Facebook has some news 2", "Facebook has some news 3", "Facebook has some news 4", "Facebook has some news 5", "YeFacebooklp has some news 6"],
                        ["Netflix has some news 1", "Netflix has some news 2", "Netflix has some news 3", "Netflix has some news 4", "Netflix has some news 5", "Netflix has some news 6"],
                        ["Yahoo has some news 1", "Yahoo has some news 2", "Yahoo has some news 3", "Yahoo has some news 4", "Yahoo has some news 5", "Yahoo has some news 6"],
                        ["Google has some news 1", "Google has some news 2", "Google has some news 3", "Google has some news 4", "Google has some news 5", "Google has some news 6"],
                        ["Indeed has some news 1", "Indeed has some news 2", "Indeed has some news 3", "Indeed has some news 4", "Indeed has some news 5", "Indeed has some news 6"],
                        ["Ritual has some news 1", "Ritual has some news 2", "Ritual has some news 3", "Ritual has some news 4", "Ritual has some news 5", "Ritual has some news 6"],
                        ["Sina has some news 1", "Sina has some news 2", "Sina has some news 3", "Sina has some news 4", "Sina has some news 5", "Sina has some news 6"],
                        ["New York Times has some news 1", "New York Times has some news 2", "New York Times has some news 3", "New York Times has some news 4", "New York Times has some news 5", "New York Times has some news 6"],
                        ["Firefox has some news 1", "Firefox has some news 2", "Firefox has some news 3", "Firefox has some news 4", "Firefox has some news 5", "Firefox has some news 6"],
                        ["Gilt has some news 1", "Gilt has some news 2", "Gilt has some news 3", "Gilt has some news 4", "Gilt has some news 5", "Gilt has some news 6"]]
  let childImages = ["c1", "c2", "c3", "c4", "c5", "c6"]
  
  var parentIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    chainCollectionView.delegate = self
    chainCollectionView.backgroundColor = UIColor(red: 237 / 255.0,
                                                  green: 231 / 255.0,
                                                  blue: 206 / 255.0,
                                                  alpha: 1.0)
    chainCollectionView.parentCollectionView.register(ImageCardCollectionViewCell.self,
                                                      forCellWithReuseIdentifier: String(describing: ImageCardCollectionViewCell.self))
    chainCollectionView.childCollectionView.register(ImageCardCollectionViewCell.self,
                                                     forCellWithReuseIdentifier: String(describing: ImageCardCollectionViewCell.self))
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.isTranslucent = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func loadView() {
    let chainView = ChainPageCollectionView(viewType: .customParentHeight(28, 12))
    chainView.parentCollectionViewItemSize = CGSize(width: 260, height: 390)
    view = chainView
  }
  
  var chainCollectionView: ChainPageCollectionView {
    return view as! ChainPageCollectionView
  }
}

extension ViewController: ChainPageCollectionViewProtocol {
  func parentCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return parentDataSource.count
  }
  
  func parentCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCardCollectionViewCell.self), for: indexPath)
    if let vCell = cell as? ImageCardCollectionViewCell {
      vCell.textLabel.text = parentDataSource[indexPath.row]
      vCell.backGroundImageView.image = UIImage(named: parentDataSource[indexPath.row])
    }
    return cell
  }
  
  
  func childCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return childDataSouce[parentIndex].count
  }
  
  func childCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCardCollectionViewCell.self), for: indexPath)
    if let vCell = cell as? ImageCardCollectionViewCell {
      vCell.textLabel.text = childDataSouce[parentIndex][indexPath.row]
      vCell.textLabel.font = UIFont.systemFont(ofSize: 18)
      vCell.backGroundImageView.image = UIImage(named: childImages[indexPath.row])
    }
    return cell
  }
  
  func childCollectionView(_ collectionView: UICollectionView, parentCollectionViewIndex: Int) {
    //chainCollectionView.childCollectionViewDataReady = true
    // NOTE: Add a little delay to let childCollectionView/layout updates its data.
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
      self.parentIndex = parentCollectionViewIndex
      self.chainCollectionView.childCollectionViewDataReady = true
    })
  }
}

