//
//  MovieView.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/17/22.
//

import SwiftUI

struct MovieView: View {
    var movie : Movie
    @State var movieViewModel = MovieViewModel()
    
    
    @Environment(\.colorScheme ) var scheme
    
    let genres: [String] = ["Action", "Romance", "Love"]
    
    init(movie: Movie) {
        // Initialize the movie property with the value of the parameter
        self.movie = movie
        
        let movieViewModel = MovieViewModel()
        movieViewModel.getMovie(movie_id: movie.id)
    }
    
    
    var body: some View {
        ZStack{
            VStack {
                AsyncImage(url: movie.backdropURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                
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
                    Text("\(movie.runtime!/60 )h")
                    
                }
                
                StarFill(rating: Int(movie.voteAverage)).padding(.vertical)
                
                VStack(alignment: .leading, content: {
                    
                    Text("Plot Summary").padding().font(.title2)
                    Text(movie.overview).font(.body).padding()
                    
                    Text("Cast").padding().font(.title2 )
                    
                })
                
                
                
            }
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
                .clear,
                .clear
            ], startPoint: .top, endPoint: .bottom)
            
            //MARK: Blurred overlay
            Rectangle()
                .fill(.ultraThinMaterial)
        }.ignoresSafeArea()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie.example()).preferredColorScheme(.dark)
    }
}
