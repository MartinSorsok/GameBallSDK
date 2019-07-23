//
//  MilestoneTableViewCell.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 4/13/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

class MilestoneTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var frubiesCounterLabel: UILabel!
    @IBOutlet weak var milestonePointsLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var milestoneImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myContentView.layer.cornerRadius = 3.0
        self.myContentView.layer.masksToBounds = false
        self.myContentView.layer.borderWidth = 1.0
        let color = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).cgColor
        self.myContentView.layer.borderColor = color
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(milestone: Milestone) {
        myLabel.text = milestone.description
        let amount = milestone.targetAmount ?? 30
        let label = String(amount) + " frubies | " + String(amount) + " points"
        frubiesCounterLabel.text = label
        milestonePointsLabel.text = String(amount)
        
        if milestone.actionsAndAmountCompletedPercentage != nil {
            DispatchQueue.main.async {
                self.progressView.properties = ProgressViewProperties(backgroundColor: Colors.appGray230, filledColor: Colors.appOrange, percentageFilled:Float((milestone.actionsAndAmountCompletedPercentage ?? 0)/100.0))
            }
            if milestone.actionsAndAmountCompletedPercentage ?? 0 == 100 {
                DispatchQueue.main.async {
                    self.milestoneImage.image = UIImage.image(named: "checkmark")
                }
            }
        }
        

        
    }
    
    
    func setLabel(test: String) {
        DispatchQueue.main.async {
//            self.myLabel.text = "HI"
        }
    }
    
}
