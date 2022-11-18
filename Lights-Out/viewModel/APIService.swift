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
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(type.self, from: data)
//                    DispatchQueue.main.async {
                        onCompletion(Result.success(result))
//                    }
                }catch {
                    onCompletion(Result.failure(error.localizedDescription as! Error))
                }
            }
        }
        task.resume()
    }
    
    
    func fetchPopularMovies(url: URL?, onCompletion: @escaping(Result<MovieModel, Error>) -> Void) {
        guard let url = url else{ return}
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else
            if let data = data{
                do{
                    let trendingMovies = try JSONDecoder().decode(MovieModel.self, from: data)
//                    DispatchQueue.main.async {
                        onCompletion(Result.success(trendingMovies))
//                    }
                }catch {
                    onCompletion(Result.failure(error.localizedDescription as! Error))
                }
            }
        }
        task.resume()
    }
    
    
}
