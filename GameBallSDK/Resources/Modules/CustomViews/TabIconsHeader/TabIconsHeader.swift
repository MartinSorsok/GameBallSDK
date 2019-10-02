//
//  TabIconsHeader.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/22/19.
//

import UIKit

class TabIconsHeader: UITableViewHeaderFooterView {


    @IBOutlet weak var pagesCollectionView: UICollectionView!
    
    weak var delegate: TabIconHeaderDelegate?
    private let tabbarCollectionViewCell = "TabbarCollectionViewCell"
 
    private var featuresArray = [0]
    var featuresArrayIcons = [""]
    
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    

    override func awakeFromNib() {
            super.awakeFromNib()
        
        configureTabBarArray()
        
            self.pagesCollectionView.dataSource = self
            self.pagesCollectionView.delegate = self
                    self.pagesCollectionView.register(UINib.init(nibName: tabbarCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: tabbarCollectionViewCell)
        self.pagesCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)

    }
    
    func configureTabBarArray(){
        //this method is created to put notification item as last item in array
        if Int(screenWidth/42) == 9 {
            //will put 8 items
            featuresArray = [Features.Profile.rawValue,
                             Features.FriendReferal.rawValue,
                             Features.LeaderBoard.rawValue,
                             Features.None.rawValue,
                             Features.None.rawValue,
                             Features.None.rawValue,
                             Features.None.rawValue,
                             Features.Notifications.rawValue]
            
             featuresArrayIcons = ["Achievements.png",
                                   "Referral.png",
                                    "Leaderboard.png",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "Notification.png"]
        } else {
            //8 
           // will put 7 items
            featuresArray = [Features.Profile.rawValue,
                            Features.FriendReferal.rawValue,
                             Features.LeaderBoard.rawValue,
                             Features.None.rawValue,
                             Features.None.rawValue,
                             Features.None.rawValue,
                             Features.Notifications.rawValue]
            
             featuresArrayIcons = ["Achievements.png",
                                    "Referral.png",
                                      "Leaderboard.png",
  
                                      "",
                                      "",
                                      "",
                                      "Notification.png"]
        }
        
    }
    
    

}
extension TabIconsHeader: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuresArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabbarCollectionViewCell, for: indexPath) as! TabbarCollectionViewCell
        cell.cellImageView.image = UIImage(named: featuresArrayIcons[indexPath.row])
        cell.cellImageView.image = cell.cellImageView?.image?.withRenderingMode(.alwaysTemplate)
        
        if indexPath.row == 0 {
            cell.tintColor = Colors.appMainColor ?? .black
            cell.lineView.backgroundColor =  Colors.appMainColor ?? .black
        } else {
            cell.tintColor = UIColor.black
            cell.lineView.isHidden = true
        }
        
        if featuresArray[indexPath.row] == Features.None.rawValue {
            cell.isHidden =  true
        }
        
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if featuresArray[indexPath.item] != Features.None.rawValue {
            let cell =  collectionView.cellForItem(at: indexPath) as! TabbarCollectionViewCell
            
            cell.cellImageView.image = cell.cellImageView?.image?.withRenderingMode(.alwaysTemplate)
            cell.tintColor = Colors.appMainColor ?? .black
            cell.lineView.isHidden = false
            cell.lineView.backgroundColor = Colors.appMainColor ?? .black
            delegate?.cellTapped(feature: featuresArray[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if featuresArray[indexPath.item] != Features.None.rawValue {

        let cell =  collectionView.cellForItem(at: indexPath) as! TabbarCollectionViewCell

        
        cell.cellImageView.image = cell.cellImageView?.image?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.black
        cell.lineView.isHidden = true
    }
    }
    
}

enum Features :Int{
    case Profile = 0
    case LeaderBoard = 1
    case FriendReferal = 2
    case Notifications = 3
    case None = -1
}
