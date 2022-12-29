//
//  APIService.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/17/22.
//

import Foundation
struct APIService {
    
    
    
    func fetch<T: Decodable>(_ type: T.Type, url: URL?, onCompletion: @escaping(Result<T, Error>) -> Void ){
        guard let url = url else{return}
        
        // Create a URLCache instance with a memory capacity of 4MB and a disk capacity of 20MB
        let cache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        if let cachedResponse = cache.cachedResponse(for: request) {
            do{
                let result = try JSONDecoder().decode(type.self, from: cachedResponse.data)
                onCompletion(Result.success(result))
            }catch{
                onCompletion(Result.failure(APIError.parsing(error as? DecodingError)))
            }
        } else {
            let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    let cachedData = CachedURLResponse(response: response!, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    do{
                        let result = try JSONDecoder().decode(type.self, from: data)
                        onCompletion(Result.success(result))
                    }catch {
                        onCompletion(Result.failure(APIError.parsing(error as? DecodingError)))
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
    func fetchPopularMovies(url: URL?, onCompletion: @escaping(Result<MovieResults, Error>) -> Void) {
        guard let url = url else{ return}
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else
            if let data = data{
                do{
                    let trendingMovies = try JSONDecoder().decode(MovieResults.self, from: data)
                    onCompletion(Result.success(trendingMovies))
                }catch {
                    onCompletion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    
}
