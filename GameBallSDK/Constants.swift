//
//  Constants.swift
//  gameball_SDK
//
//  Created by Martin Sorsok on 2/3/19.
//  Copyright © 2019 Martin Sorsok. All rights reserved.
//

import Foundation
import UIKit

//COMMENT ALL THE CLASS WHEN GO PRODUCTION
//class TestingServer
//{
//    static let shared = TestingServer()
//
//    var base_URL = ""
//    private init()
//    {
//           if UserDefaults.standard.bool(forKey: "prod") {
//
//             base_URL = "api.gameball.co"
//           } else {
//
//             base_URL = "gb-api.azurewebsites.net"
//
//           }
//    }
//}


class APIEndPoints {

    //PRODUCTION
    static let base_URL = "api.gameball.co"

    static let appPort = 8092
    
    static let getBotStyle = "/api/v1.0/Bots/BotSettings"
    static let getChallengesWithUnlocks = "/api/v1.0/Bots/challenges"
    static let getLeaderboards = "/api/v1.0/Bots/LeaderboardWithRank"
    static let getPlayerInfo = "/api/v1.0/Bots/PlayerInfo"
    static let postAction = "/api/v1.0/Integrations/Action"
    static let getNotifications = "/api/v1.0/Bots/notifications"

    static let registerPlayer = "/api/v1.0/Integrations/InitializePlayer"

    static let friendReferral = "/api/v1.0/Integrations/Referral"

    static let getPlayerNextLevel = "/api/Bots/GetNextLevel"
    static let getPlayerDetails = "/api/Bots/GetPlayerDetails"
    static let generateOTP = "/api/Integration/OTP"
    static let rewardPoints = "/api/Integration/Transaction/Reward"
    static let holdPoints = "/api/Integration/Transaction/Hold"
    static let redeemPoints = "/api/Integration/Transaction/Redeem"
    static let reversePoints = "/api/Integration/Transaction/Hold"
    static let getPlayerBalance = "/api/Integration/Transaction/Balance"


}

struct Colors {
    static let appGray173 = UIColor(white: 173 / 255, alpha: 1)
    static let appGray230 = UIColor(white: 230 / 255, alpha: 1)
    static let appGray103 = UIColor(white: 103 / 255, alpha: 1)
    static let appGray204 = UIColor(white: 204 / 255, alpha: 1)
    static let appGray239 = UIColor(white: 239 / 255, alpha: 1)
    static let curvedViewColor = UIColor(red: 239/256, green: 239/256, blue: 239/256, alpha: 1)
     static let appGray153 = UIColor(red: 153/256, green: 153/256, blue: 153/256, alpha: 1)
    static let appBlack26 = UIColor(red: 26/256, green: 26/256, blue: 26/256, alpha: 1)
    static let appGray170 = UIColor(red: 170/256, green: 170/256, blue: 170/256, alpha: 1)

      static let appGray128 = UIColor(red: 128/256, green: 128/256, blue: 128/256, alpha: 1)
     static let appGray242 = UIColor(red: 242/256, green: 242/256, blue: 242/256, alpha: 1)
        static let appGray225 = UIColor(red: 225/256, green: 225/256, blue: 225/256, alpha: 1)
//    static let curvedViewColor = UIColor(displayP3Red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    static let appGray74 = UIColor(white: 74 / 255, alpha: 1)
    static let appGray130 = UIColor(white: 130 / 255, alpha: 1)
    static let appCustomDarkGray = UIColor(red: 68 / 255, green: 76 / 255, blue: 82 / 255, alpha: 1.0)
    static let appOrange = UIColor(red: 240 / 255, green: 90 / 255, blue: 42 / 255, alpha: 1.0)
    static let appMainColor = UIColor.init(hex: GameballApp.clientBotStyle?.botMainColor ?? "#E7633F")
    static let progressMainColor =  UIColor(red: 100 / 255, green: 202 / 255, blue: 98 / 255, alpha: 1.0)

    
}

struct Fonts {
    static let appFont14 = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    static let appFont14Bold = UIFont.systemFont(ofSize: 14.0, weight: .bold)
    static let appFont18 = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    static let appFont13 = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
    static let appFont12 = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    static let appFont12Light = UIFont.systemFont(ofSize: 12.0, weight: .light)
    static let appFont20Bold = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    static let appFont16Regular = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    static let appFont24Regular = UIFont.systemFont(ofSize: 24.0, weight: .regular)
    static let achievementCellPointsFont = UIFont.systemFont(ofSize: 10.0, weight: .bold)

    static let badgeNameFont =  UIFont(name: "Poppins-Black", size: UIFont.labelFontSize)
    
    static let cairoRegularFont10 =  UIFont(name: "Cairo-Regular", size: 10.0)
    static let cairoRegularFont12 =  UIFont(name: "Cairo-Regular", size: 12.0)
    static let cairoRegularFont14 =  UIFont(name: "Cairo-Regular", size: 14.0)
    static let cairoRegularFont16 =  UIFont(name: "Cairo-Regular", size: 16.0)
  static let cairoRegularFont28 =  UIFont(name: "Cairo-Regular", size: 28.0)
    static let cairoBoldFont8 =  UIFont(name: "Cairo-Bold", size: 8.0)
    static let cairoBoldFont10 =  UIFont(name: "Cairo-Bold", size: 10.0)

    static let cairoBoldFont12 =  UIFont(name: "Cairo-Bold", size: 12.0)
    static let cairoBoldFont14 =  UIFont(name: "Cairo-Bold", size: 14.0)
    static let cairoBoldFont16 =  UIFont(name: "Cairo-Bold", size: 16.0)
    static let cairoBoldFont20 =  UIFont(name: "Cairo-Bold", size: 20.0)

    static let montserratSemiBoldFont8 =  UIFont(name: "Montserrat-SemiBold", size: 8.0)
    static let montserratSemiBoldFont10 =  UIFont(name: "Montserrat-SemiBold", size: 10.0)
    static let montserratSemiBoldFont12 =  UIFont(name: "Montserrat-SemiBold", size: 12.0)
    static let montserratSemiBoldFont14 =  UIFont(name: "Montserrat-SemiBold", size: 14.0)
    static let montserratSemiBoldFont16 =  UIFont(name: "Montserrat-SemiBold", size: 16.0)
    static let montserratSemiBoldFont20 =  UIFont(name: "Montserrat-SemiBold", size: 20.0)

    static let montserratLightFont10 =  UIFont(name: "Montserrat-Light", size: 10.0)
    static let montserratLightFont12 =  UIFont(name: "Montserrat-Light", size: 12.0)
    static let montserratLightFont14 =  UIFont(name: "Montserrat-Light", size: 14.0)
    static let montserratLightFont16 =  UIFont(name: "Montserrat-Light", size: 16.0)
    static let montserratLightFont28 =  UIFont(name: "Montserrat-Light", size: 28.0)
}

enum UserDefaultsKeys: String {
    case playerUniqueId = "gameballSDKPlayerID"
    case playerCategoryId = "gameballSDKPlayerCategoryID"
    case APIKey = "gameballSDKAPIKey"
    case LanguageKey = "languageKey"
    case PlayerAttributes = "PlayerAttributesKey"

}

let transactionkey = "5sdfd2dvvd-9mnvhu25d6c3d"
let nc = NotificationCenter.default
