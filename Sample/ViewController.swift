//
//  ViewController.swift
//  Sample
//
//  Created by limao on 16/6/14.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UIScrollViewDelegate {
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: CollectionLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.lightGrayColor()
        collectionView.delegate = self
        collectionView.dataSource = self
    

        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.registerClass(CollectionViewBannerCell.self, forCellWithReuseIdentifier: CollectionViewBannerCell.identifier)
        collectionView.registerClass(CollectionViewButtonsCell.self, forCellWithReuseIdentifier: CollectionViewButtonsCell.identifier)

        collectionView.registerClass(Header.self, forSupplementaryViewOfKind: Header.kind, withReuseIdentifier: Header.identifier)

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 8
        } else {
            return 100
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
         
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewBannerCell.identifier, forIndexPath: indexPath) as! CollectionViewBannerCell
            return cell

        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewButtonsCell.identifier, forIndexPath: indexPath) as! CollectionViewButtonsCell
            return cell
        } else {
           let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.identifier, forIndexPath: indexPath) as! CollectionViewCell
            return cell

        }
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            if indexPath.section == 2 {
                let header = collectionView.dequeueReusableSupplementaryViewOfKind(Header.kind, withReuseIdentifier: Header.identifier, forIndexPath: indexPath)
                return header
            } else {
                return UICollectionReusableView()
            }
       }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeMake(Tool.width, 200)
        } else if indexPath.section == 1 {
            return CGSizeMake(Tool.width / 2 - 0.5, 50)
        } else {
            return CGSizeMake(Tool.width / 2 - 5, 100)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSizeMake(Tool.width, 50)
        } else {
            return CGSizeZero
        }
    }
    
   
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard  let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else {
            return
        }
        statusBar.backgroundColor = color
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class CollectionLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumInteritemSpacing = 0.5
        self.minimumLineSpacing = 0.5
        if #available(iOS 9.0, *) {
            self.sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class CollectionViewBannerCell: UICollectionViewCell {
    static let identifier = "banner"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.brownColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewButtonsCell: UICollectionViewCell {
    static let identifier = "button"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class Header: UICollectionReusableView {
    
    static let identifier = "header"
    static let kind = "UICollectionElementKindSectionHeader"
    
    var segmentControl: SegmentControlView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        segmentControl = SegmentControlView.init()
        self.addSubview(segmentControl)
        segmentControl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        segmentControl.titles = ["呵呵呵", "哈哈哈","嘿嘿嘿"]
        segmentControl.currentIndex = 0
        segmentControl.selectionHandler = { index in
            print("index: \(index)")
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SegmentControlView : UIView {
    
    var buttons:[UIButton]?
    
    var selectionHandler: (Int -> Void)?
    
    var prefixIndex: Int = 0
    var currentIndex: Int = 0 {
        willSet{
            for i in 0...2 {
                if newValue == i {
                    self.buttons?[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    self.buttons?[i].backgroundColor = UIColor.brownColor()
                } else {
                    self.buttons?[i].setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.buttons?[i].backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    var titles:[String]? {
        willSet{
            if let _ = newValue {
                for i in 0...2 {
                    buttons?[i].setTitle(newValue![i], forState: .Normal)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttons = [UIButton]()
        let buttonMargin: CGFloat = 20.0
        let buttonWidth = (frame.size.width - 6 * buttonMargin) / 3
        
        for i in 0...2 {
            let button = UIButton.init(type: .Custom)
            button.tag = i
            self.addSubview(button)
            
            button.frame = CGRectMake(buttonMargin * ((CGFloat(i) * 2) + 1) + CGFloat(i) * buttonWidth, 3, buttonWidth, frame.size.height - 6)
            button.layer.cornerRadius = frame.size.height / 2 - 3
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(self.didClickItem(_:)), forControlEvents: .TouchUpInside)
            button.backgroundColor = UIColor.whiteColor()
            buttons?.append(button)
        }
    }
    
    func didClickItem(btn: UIButton) {
        self.currentIndex = btn.tag
        if prefixIndex != currentIndex {
            self.selectionHandler?(btn.tag)
        }
        self.prefixIndex = self.currentIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







extension UIView {
    var x: CGFloat { return self.frame.origin.x}
    var y: CGFloat { return self.frame.origin.y}
    var w: CGFloat { return self.frame.size.width}
    var h: CGFloat { return self.frame.size.height}

}


//
struct Tool {
    static let width = UIScreen.mainScreen().bounds.size.width
}

