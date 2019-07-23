//
//  TabbarCollectionViewCell.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 3/19/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class TabbarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!{
        didSet{
            cellImageView.image = cellImageView.image?.withRenderingMode(.alwaysTemplate)
            cellImageView.tintColor = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
   
    @IBOutlet weak var lineView: UIView!{
        didSet{
            lineView.backgroundColor =  UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
