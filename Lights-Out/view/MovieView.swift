//
//  MovieView.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/17/22.
//

import SwiftUI

struct MovieView: View {
    var movie : Movie
    @ObservedObject var movieViewModel = MovieViewModel()
    @Environment(\.colorScheme ) var scheme
    
    let genres: [String] = ["Action", "Romance", "Love"]
    init(movie: Movie) {
        // Initialize the movie property with the value of the parameter
        self.movie = movie
        movieViewModel.getMovie(movie_id: movie.id)
        //movieViewModel.getCasting(movie_id: movie.id)
    }
    
    func loadJson() -> [Cast]? {
        let url = Bundle.main.url(forResource: "CastData", withExtension: "JSON")
        do {
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Cast].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
        return nil
    }
    
    
    
    var body: some View {
        ZStack{
            BGView()
            
            
            ScrollView(.vertical){
                
                VStack {
                    
                    Text((movie.originalName ?? movie.title)!).font(.largeTitle)
                    HStack{
                        Text((String((movie.releaseDate ?? movie.firstAirDate)!.prefix(4))))
                        Image(systemName: "circle.fill").font(.system(size:8))
                        
                        ForEach(genres, id:\.self) { genre in
                            Text(genre+",")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        Image(systemName: "circle.fill").font(.system(size:8))
                        //                        Text("\((movieViewModel.selectedMovie?.runtime!)!/60 )h")
                        Text("2022") //debug
                        
                    }
                    
                    StarFill(rating: Int(movie.voteAverage)).padding(.vertical)
                    
                    VStack(alignment: .leading, content: {
                        
                        Text("Plot Summary").padding().font(.headline)
                        Text(movie.overview).font(.body).padding(.horizontal)
                        
                        Text("Cast").padding().font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                
                                ForEach(loadJson()!, id:\.id) { cast in
                                    
                                    VStack {
                                        AsyncImage(url: cast.profileURL) { image
                                            in image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Text(cast.name).font(.system(size: 13))
                                        Text(cast.character ?? cast.name).font(.subheadline)
                                        
                                        
                                    }
                                }.padding(.trailing)
                                
                                
                            }
                        }.padding(.horizontal)
                        
                    })
                    
                    
                }
            }
            .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 200.0)
        }
    }
    
    
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(){
                
                
                AsyncImage(url: movie.posterURL) { image
                    in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:size.width, height: size.height)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                
            }
            
            //MARK: Custom Gradient
            let color : Color = (scheme == .dark ? .black : .white)
            LinearGradient(colors:[
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            //MARK: Blurred overlay
            //            Rectangle()
            //                .fill(.ultraThinMaterial)
        }.ignoresSafeArea()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie.example()).preferredColorScheme(.dark)
    }
}
