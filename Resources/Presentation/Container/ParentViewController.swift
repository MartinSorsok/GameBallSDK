//
//  ParentViewController.swift
//  gameballSDK
//
//  Created by Ahmed Abodeif on 3/17/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func dataReady(collectionView: UICollectionView)
}
class ParentViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet private weak var profileHeaderView: ProfileHeaderView!

    //    let color = UIColor.init(hex: GameballApp.clientBotStyle?.botMainColor ?? "#E7633F")
    let unselectedIconColor = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F") ?? UIColor.orange
   let userCache = UserProfileCache.get()
    private let mainTableViewCell = "MainTableViewCell"
    private let badgesCollectionViewinCell = "BadgesCollectionViewinCell"
    private let tabIconsHeader = "TabIconsHeader"


    private let challengesViewModel = ChallengesViewModel()
    
    private var challenges: [Challenge] = []
    private var quests: [Quest] = []
    
    
    @IBOutlet weak var weRunOnLabel: UILabel!{
        didSet{
            weRunOnLabel.text = LocalizationsKeys.General.gameballFooterText.rawValue.localized
            weRunOnLabel.textColor = Colors.appGray153
            
            if Localizator.sharedInstance.language == Languages.arabic {
                weRunOnLabel.font = Fonts.cairoRegularFont12
            } else {
                weRunOnLabel.font = Fonts.montserratLightFont12
            }
        }
    }
    
    @IBOutlet weak var gameBallLabel: UILabel!{
        didSet{
            gameBallLabel.text = "Gameball"
            gameBallLabel.textColor = Colors.appGray153
            if Localizator.sharedInstance.language == Languages.arabic {
                gameBallLabel.font = Fonts.cairoBoldFont12
            } else {
                gameBallLabel.font = Fonts.montserratSemiBoldFont10
            }
        }
    }
    
    
    public init() {
        let b = Bundle.init(for: type(of: self))
        super.init(nibName: "ParentViewController", bundle: Bundle.init(for: type(of: self)))
//        self.buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: "TabbarCollectionViewCell", bundle: b, width: { _ in
//            return 55.0
//        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let purpleInspireColor = UIColor.init(hex: GameballApp.clientBotStyle?.buttonBackgroundColor ?? "#E7633F")
    
    override func viewDidLoad() {
//        // change selected bar color
//        settings.style.buttonBarBackgroundColor = .white
////        self.gameballBannerView.backgroundColor = unselectedIconColor
//
////        settings.style.buttonBarItemBackgroundColor = .white
//        settings.style.selectedBarBackgroundColor = unselectedIconColor
//        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
//        settings.style.selectedBarHeight = 3.0
//        settings.style.buttonBarMinimumLineSpacing = 0
//        settings.style.buttonBarItemsShouldFillAvailableWidth = false
////        settings.style.buttonBarLeftContentInset = 10
//        settings.style.buttonBarItemLeftRightMargin = 40
//        settings.style.buttonBarHeight = 10
//        settings.style.buttonBarRightContentInset = 0
//
//        changeCurrentIndexProgressive = { [weak self] (oldCell: TabbarCollectionViewCell?, newCell: TabbarCollectionViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
//            guard changeCurrentIndex == true else { return }
//            oldCell?.cellImageView.contentMode = .scaleAspectFit
//            oldCell?.cellImageView.tintColor = UIColor.black
//            newCell?.cellImageView.contentMode = .scaleAspectFit
//            newCell?.cellImageView.tintColor = self?.unselectedIconColor
//        }

        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        mainTableView.register(UINib(nibName: mainTableViewCell, bundle: nil), forCellReuseIdentifier: mainTableViewCell)
        mainTableView.register(UINib(nibName: badgesCollectionViewinCell, bundle: nil), forCellReuseIdentifier: badgesCollectionViewinCell)
        mainTableView.register(UINib(nibName: tabIconsHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: tabIconsHeader)
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 600
        mainTableView.tableFooterView = UIView()
self.navigationController?.navigationBar.isHidden = true
    }

    

    private func getSettings(completion: @escaping () -> Void) {
        let settingsViewModel = ClientBotSettingsViewModel()
        settingsViewModel.getClientBotStyle(completion: {
            error in
            if error != nil {
                // handle error
            }
            else {
                GameballApp.clientBotStyle = settingsViewModel.botStyle
                completion()
            }
        })
    }
    

//    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//
//
//        let child_1 = GameballViewController()
//        let child_2 = LeaderboardViewController()
//
//        if GameballApp.clientBotStyle?.enableLeaderboard ?? false{
//
//            return [child_1, child_2]
//        } else {
//            return [child_1]
//        }
//        }
//
    
//    override func configure(cell: TabbarCollectionViewCell, for indicatorInfo: IndicatorInfo) {
//        cell.cellImageView.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
//    }
//
//        override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
//            super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
//            if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
//                let child = viewControllers[toIndex] as! IndicatorInfoProvider // swiftlint:disable:this force_cast
//                UIView.performWithoutAnimation({ [weak self] () -> Void in
//                    guard let me = self else { return }
//                    me.navigationItem.leftBarButtonItem?.title =  child.indicatorInfo(for: me).title
//                })
//            }
//        }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
        return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0

        } else {

        return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: tabIconsHeader) as! TabIconsHeader
        
        return headerView

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mainTableViewCell) as! MainTableViewCell
            return cell
        } else if indexPath.section == 1{

            let cell = tableView.dequeueReusableCell(withIdentifier: badgesCollectionViewinCell) as! BadgesCollectionViewinCell
            cell.delegate = self
            cell.frame = tableView.bounds;  // cell of myTableView
            cell.collectionView.reloadData()
            cell.layoutIfNeeded()

            cell.collectionViewHeight.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height;
            return cell
        }
        return UITableViewCell()
    }
}


extension ParentViewController: TabBarDelegate {
    func dataReady(collectionView: UICollectionView){
        DispatchQueue.main.async {
            self.mainTableView.reloadData()

        }
        
    }
    
    
    
}
