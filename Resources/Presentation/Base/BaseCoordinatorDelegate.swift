//
//  BaseCoordinatorDelegate.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/8/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCoordinatorDelegate: NSObjectProtocol {
    func push(_ viewController: UIViewController, animated: Bool)
}
