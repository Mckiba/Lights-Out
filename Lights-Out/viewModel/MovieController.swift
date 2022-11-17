//
//  MovieController.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/13/22.
//

import Foundation
class MovieViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var movieThings: MovieModel!
    
    init(){
        getPopularMovies()
    }
    
    func getPopularMovies(){
        isLoading = true
        let apiKey: String = ProcessInfo.processInfo.environment["TMD_API_KEY"]!
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)")
        else{
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            }else
            if let data = data,
               let trendingMovies = try? JSONDecoder().decode(MovieModel.self, from: data) {
                DispatchQueue.main.async {
                    self.movieThings = trendingMovies
                    self.isLoading = false
                }
            }
        }
        task.resume()
    }
}

