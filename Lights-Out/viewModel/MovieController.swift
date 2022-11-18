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
    let apiKey: String = ProcessInfo.processInfo.environment["TMDB_API_KEY"]!
    
    
    init(){
        getPopularMovies()
    }
    
    
    func getPopularMovies(){
        let service = APIService()
        isLoading = true
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)") else {return}
        service.fetchPopularMovies(url: url) { result in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error) :
                    print(error)
                    
                case .success(let movie):
                    self.movieThings = movie
                    self.isLoading = false
                }
            }
        }
    }
    
   
    
}

