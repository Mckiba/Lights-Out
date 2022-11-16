//
//  MovieController.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/13/22.
//

import Foundation



class MovieViewModel: ObservableObject {
    
//    @Published var isLoading: Bool = false
    @Published var movieThings: MovieModel!
    
    
    init() {
         getPopularMovies()
    }
    
    func getPopularMovies(){
        
 
            guard let url = URL(string: "https://api.themoviedb.org/3/trending/tv/week?api_key=599b0cb2f39931497a62cbf1b2c057c8")
            else{
                return
            }
            
            let json = try! String(contentsOf: url)
            do{
                self.movieThings = try MovieModel(json)
            }catch{
                print(String(describing: error))
            }
     }
//        let task = URLSession.shared.dataTask(with: url) { data, res, error in
//
//            guard let data = data else {
//                print(String(describing: error))
//                return
//            }
//            //print(String(data: data, encoding: .utf8)!)
//            do{
//                let movies = try JSONDecoder().decode(MovieModel.self, from: data)
//                 DispatchQueue.main.async {
//
//                       print(movies)
//                }
//             }catch{
//                print(String(describing: error))
//            }
        
         
    }
    
