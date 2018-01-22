//
//  WPCollectionView.swift
//  DOIT
//
//  Created by WANG on 2018/1/12.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit
let reuseIdentifier:String = "ReuseIdentifier"

class WPCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventsTitleLabel: UITextField!
    
    @IBOutlet weak var eventsImage: UIImageView!

}
class WPCollectionView: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    var dataSources:[String] = Array()
    
   var collectionView:UICollectionView?

    
    init(datasource:[String]) {
        super.init(frame:CGRect.init(x: 0, y:65, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height/3))
        self.dataSources = datasource
        createCollectionView()
    }
    
    func createCollectionView() {
        
        
        collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout:WPLayout())
        collectionView?.register(UINib.init(nibName: "WPCollectionViewCell", bundle:nil), forCellWithReuseIdentifier:reuseIdentifier)
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor =  BACKGARYCOLOR
        self.addSubview(collectionView!)
        self.collectionView?.dataSource = self
        
        
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSources.count
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        
        let cell:WPCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WPCollectionViewCell
        cell.eventsTitleLabel.text = self.dataSources[indexPath.row]
        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
class WPLayout:UICollectionViewLayout {
    
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    var totalNum:Int = 0
    
    override func prepare() {
        super.prepare()
        totalNum = (collectionView?.numberOfItems(inSection: 0))!
        
        var indexpath:IndexPath
        
        for index in 0..<totalNum {
            
            indexpath = IndexPath.init(row: index, section: 0)
            layoutAttributes.append(layoutAttributesForItem(at: indexpath)!)
        }
        
        
    }
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize.init(width: UIScreen.main.bounds.size.width*3, height:UIScreen.main.bounds.size.height/3)
    }
   
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let centerWidth:CGFloat = ((self.collectionView?.bounds.size.width)!/2)
        let attributes:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attributes.size = CGSize.init(width: (self.collectionView?.bounds.size.width)! - 40, height: (self.collectionView?.bounds.size.height)! - 40)
        attributes.center = CGPoint.init(x:(self.collectionView?.bounds.size.width)!*CGFloat(indexPath.row)+centerWidth, y: (self.collectionView?.bounds.size.height)!/2)

        return attributes
        
    }
   
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
