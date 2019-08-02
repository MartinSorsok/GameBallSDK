//
//  LocalizationsKeys.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/21/19.
//

import UIKit

class LocalizationsKeys: NSObject {

    
    enum General: String {
        case gameballFooterText = "GameballFooterText"
    }
    
    
    enum GameballScreen :String{
        case achievementTitle = "AchievementTitle"
        case  pts = "pts"
        case  pointsName = "pointsName"
        case  rankPointsName = "RankPointsName"
        case  nextLevelText = "NextLevelText"
        case  welcomeText = "Welcome"
        case  youAreOnLevelText = "You are on level"


    }
    
    enum LeaderBoardScreen :String{
        case  leaderboardTitle = "LeaderboardTitle"
        case  yourRank = "Your rank"
        case score = "Score"
    }
    enum FriendReferalScreen :String{
        case  copy = "Copy"
     
    }
    
    enum ChallengeDetails :String{
        case  status = "Status"
        case  times = "Times"
        case  locked = "Locked"
        case  achieved = "Achieved"
        case  keepGoing = "Keep going"
        case  YouNeed = "You need to be on"
        case  toUnlock = "to unlock this challenge"
        case  progress = "Progress"
        
        case  trackProgress = "Track your progress here"
        case  highScore = "High Score"
        case  yourHighScore = "Your high score is"
        case  breakYourHighScore = "Break your high score and win this badge again!"
        case  friendsRemaining = "friend(s) remaining to achieve this badge"



   }
    
}
