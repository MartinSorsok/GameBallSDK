//
//  TabIconsHeader.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 7/22/19.
//

import UIKit

class TabIconsHeader: UITableViewHeaderFooterView {


    @IBOutlet weak var pagesCollectionView: UICollectionView!
    
    private let tabbarCollectionViewCell = "TabbarCollectionViewCell"
    override func awakeFromNib() {
            super.awakeFromNib()
            
            self.pagesCollectionView.dataSource = self
            self.pagesCollectionView.delegate = self
                    self.pagesCollectionView.register(UINib.init(nibName: tabbarCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: tabbarCollectionViewCell)
    }

}
extension TabIconsHeader: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabbarCollectionViewCell, for: indexPath) as! TabbarCollectionViewCell
        return cell
    }
    
    
    
}
