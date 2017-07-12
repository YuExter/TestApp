//
//  NetworkManager.swift
//  TestApp
//
//  Created by Юля Пономарева on 12.07.17.
//  Copyright © 2017 Юля Пономарева. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Unbox

struct NetworkManager {
    
    //example without Rx
    func getDataForImageFromURL(completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "https://httpbin.org/image/png")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }    
    
    //example with Rx
    func downloadText() -> Observable<MainModel> {
        let url = URL(string: "https://httpbin.org/get")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        return URLSession.shared.rx.response(request: request).asObservable().flatMap { (_, data) -> Observable<MainModel> in
            if let model: MainModel = try? unbox(data: data) {
                return Observable.just(model)
            } else {
                let err = NSError()
                return Observable.error(err.localizedDescription as! Error)
            }
        }
    }
}
