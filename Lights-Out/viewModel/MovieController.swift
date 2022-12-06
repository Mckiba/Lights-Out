//
//  MovieController.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/13/22.
//

import Foundation
class MovieViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var movieThings: MovieResults!
    @Published var selectedMovie: Movie?
    let apiKey: String = ProcessInfo.processInfo.environment["TMDB_API_KEY"]!
    let service = APIService()

    
    init(){
        getPopularMovies()
    }
    
    
    func getPopularMovies(){
        isLoading = true
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else {return}
        service.fetch(MovieResults.self, url: url) { result in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error) :
                    print(error.localizedDescription)
                    
                case .success(let movie):
                    self.movieThings = movie
                    self.isLoading = false
                }
            }
        }
    }
    
    func getMovie(movie_id: Int){
        isLoading = true
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_id)?api_key=\(apiKey)&&append_to_response=videos")
        else {
            print(APIError.badURL.description)
            return
        }
         service.fetch(Movie.self, url: url) { result in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error) :
                    print("Error: \(error)")
                    
                case .success(let movie):
                    self.selectedMovie = movie
                     self.isLoading = false
                }
            }
        }
    }

    
    
    
   
    
}

