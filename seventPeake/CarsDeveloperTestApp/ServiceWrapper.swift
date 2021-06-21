//
//  ServiceWrapper.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 22/4/2564 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ServiceWrapperProtocol {
    func serviceResponse(request: URLRequest, completion: @escaping (Data?,WebServiceStatus) -> Void)
}

class ServiceWrapper: ServiceWrapperProtocol {

    func serviceResponse(request: URLRequest,completion : @escaping (Data?,WebServiceStatus) -> Void) {
        AF.request(request).responseJSON { (response) in
            
            print("request: \(request)")
            print("status code: \(String(describing: response.response?.statusCode))")
            print("data: \(String(describing: response.result))")
            
            switch response.response?.statusCode {
                case 200:
                    completion(response.data!, .success)
                    break
                case 204:
                    completion(nil, .noContent)
                    break
                case 400:
                    completion(nil, .badRequest)
                    break
                case 401:
                    completion(nil, .unAuthorized)
                    break
                case 500:
                    completion(nil, .internalServerError)
                    break
                case nil:
                    completion(nil, .null)
                    break
                default :
                    completion(nil, .null)
            }
        }
    }
}

enum WebServiceStatus{
    case success
    case noContent
    case badRequest
    case unAuthorized
    case internalServerError
    case null
}
