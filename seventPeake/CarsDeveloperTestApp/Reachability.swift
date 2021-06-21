//
//  Reachability.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 28/4/2564 BE.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
