//
//  APIError.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/4/22.
//

import Foundation

enum APIError: Error {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    case invalidResponse
    case invalidURL
    
    
    var localizedDescription: String {
        switch self {
            
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong"
            
        case .badResponse(_):
            return "Sorry, connection to our Server failed"
            
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
            
        case .invalidResponse:
            return "The server returned an invalid response"
            
        case .invalidURL:
            return "The provided URL is invalid"
        }
        
        
    }
    
    var description: String {
        switch self {
            
        case .unknown:
            return "Unknown error"
            
        case .badURL:
            return "Invalid URL"
            
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
            
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
            
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
            
        case .invalidResponse:
            return "Invalid Response"
            
        case .invalidURL:
            return "Invalid URL"
        }
    }
    
}
