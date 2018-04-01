//
//  WebServiceConfiguration.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 30/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

internal struct WebServiceConfiguration {
    let language: String
    
    private class Dummy {}
    
    static let `default` = WebServiceConfiguration(language: Bundle.main.preferredLocalizations[0])
    
    var parameters: [String: String] {
//        return ["language": language]
        return [:]
    }
}
