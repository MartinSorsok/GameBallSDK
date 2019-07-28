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
   var mainAppColor =  UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
    private var featuresArray = [Features.Profile.rawValue, Features.LeaderBoard.rawValue , Features.FriendReferal.rawValue]
    var featuresArrayIcons = ["Achievements.png","Leaderboard.png","Referral.png"]
    override func awakeFromNib() {
            super.awakeFromNib()
            
            self.pagesCollectionView.dataSource = self
            self.pagesCollectionView.delegate = self
                    self.pagesCollectionView.register(UINib.init(nibName: tabbarCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: tabbarCollectionViewCell)
        self.pagesCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)

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
            cell.tintColor = mainAppColor
            cell.lineView.backgroundColor =  mainAppColor
        } else {
            cell.tintColor = UIColor.black
            cell.lineView.isHidden = true
        }
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
       let cell =  collectionView.cellForItem(at: indexPath) as! TabbarCollectionViewCell
        
        cell.cellImageView.image = cell.cellImageView?.image?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = mainAppColor
        cell.lineView.isHidden = false
        cell.lineView.backgroundColor = mainAppColor

        delegate?.cellTapped(feature: featuresArray[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath) as! TabbarCollectionViewCell

        cell.cellImageView.image = cell.cellImageView?.image?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.black
        cell.lineView.isHidden = true
    }
    
    
}

enum Features :Int{
    case Profile = 0
    case LeaderBoard = 1
    case FriendReferal = 2
}
