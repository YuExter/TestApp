//
//  HeaderModel.swift
//  TestApp
//
//  Created by Юля Пономарева on 12.07.17.
//  Copyright © 2017 Юля Пономарева. All rights reserved.
//

import UIKit
import Unbox

struct HeaderModel {
    let accept: String?
    let acceptEncoding: String?
    let acceptLanguage: String?
    let connection: String?
    let host: String?
    let userAgent: String?
}

extension HeaderModel: Unboxable {
    init(unboxer: Unboxer) throws {
        self.accept = try unboxer.unbox(key: "Accept")
        self.acceptEncoding = try unboxer.unbox(key: "Accept-Encoding")
        self.acceptLanguage = try unboxer.unbox(key: "Accept-Language")
        self.connection = try unboxer.unbox(key: "Connection")
        self.host = try unboxer.unbox(key: "Host")
        self.userAgent = try unboxer.unbox(key: "User-Agent")
    }
}
