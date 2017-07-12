//
//  MainModel.swift
//  TestApp
//
//  Created by Юля Пономарева on 12.07.17.
//  Copyright © 2017 Юля Пономарева. All rights reserved.
//

import UIKit
import Unbox

struct MainModel {
    let headers: HeaderModel
    let origin: String?
    let url: String?
}

extension MainModel: Unboxable {
    init(unboxer: Unboxer) throws {
        self.headers = try unboxer.unbox(key: "headers")
        self.origin = try unboxer.unbox(key: "origin")
        self.url = try unboxer.unbox(key: "url")
    }
}
