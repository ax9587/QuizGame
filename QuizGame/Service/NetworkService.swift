//
//  NetworkService.swift
//  QuizGame
//
//  Created by AlexX on 2022-11-09.
//

import Foundation

import UIKit

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}



extension URL {
    
    static func forTriviaSetId(_ id: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AppConfig.urlHost
        components.path = "/api/ios/trivias/\(id)"
        return components.url
    }
    
    static var forAllTrivias: URL {
        URL(string:  AppConfig.urlBaseString+"/ios/trivias")!
    }
    
    static var forPostProduct: URL {
        URL(string: AppConfig.urlBaseString+"/ios/trivias")!
    }
}

extension TriviaItem {
    
//    static func postProduct(_ data: Product) -> Resource<Product> {
//        guard let encoded = try? JSONEncoder().encode(data) else {
//            print("Failed to encode product")
//            fatalError("product was not proceesiable.")
//        }
//        return Resource(url: URL.forPostProduct,method: .post(encoded))
//    }
    
    static var all: Resource<[TriviaItem]> {
        return Resource(url: URL.forAllTrivias)
    }
}

extension TriviaSet {
    
    static func byId(_ id: Int) -> Resource<TriviaSet> {
        guard let url = URL.forTriviaSetId(id) else {
            fatalError("id = \(id) was not found.")
        }
        return Resource(url: url)
    }
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
        }
    }
}

struct Resource<T: Codable> {
    
    let url: URL
    var method: HttpMethod = .get([])
}

class Webservice {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            case .get(let queryItems): // https://someurl.com/products?sort=asc&pageSize=10
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                    throw NetworkError.badUrl
                }
                print(url)
                request = URLRequest(url: url)
        }
        
        // create the URLSession configuration
        let configuration = URLSessionConfiguration.default
        // add default headers
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        //debug decodingError
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
        
    }
    
}

//Task {
    // get all products
    //let products = try await Webservice().load(Product.all)
    //print(products)
//}

//Task {
   // let product = try await Webservice().load(Product.byId(1))
   // print(product)
//}

