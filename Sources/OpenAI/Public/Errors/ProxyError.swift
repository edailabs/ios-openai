//
//  File.swift
//  OpenAI
//
//  Created by Olivier on 10/12/2024.
//

import Foundation

struct ProxyErrorResponse: Decodable {
    
    // Attributes
    let fault: Fault
    
    // Models
    struct Fault: Decodable {
        let faultstring: String
        let detail: Detail
    }
    
    struct Detail: Decodable {
        let errorcode: String
        
        // Helpers
        var asError: ProxyError {
            .init(rawValue: errorcode) ?? .unkonwn
        }
    }
}

// Models
public enum ProxyError: String, Error {
    case invalidToken = "steps.jwt.InvalidToken"
    case unkonwn
}
