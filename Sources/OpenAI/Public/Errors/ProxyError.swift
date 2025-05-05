//
//  ProxyError.swift
//  OpenAI
//
//  Created by Olivier on 10/12/2024.
//

import Foundation

struct ProxyErrorResponse: ErrorResponse {

    public var error: ProxyError
    public var errorDescription: String?

}

struct RawProxyErrorResponse: Decodable {
    
    // Attributes
    let fault: Fault
    
    // Models
    struct Fault: Decodable {
        let faultstring: String
        let detail: Detail
    }
    
    struct Detail: Decodable {
        let errorcode: String
    }

    func asProxyErrorResponse() -> ProxyErrorResponse {
        let proxyError = ProxyError(rawValue: fault.detail.errorcode) ?? .unknown
        return .init(
            error: proxyError,
            errorDescription: fault.faultstring
        )
    }

}

// Models
public enum ProxyError: String, LocalizedError, Decodable {
    case invalidToken = "steps.jwt.InvalidToken"
    case unknown
}
