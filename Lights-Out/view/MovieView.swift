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

         // Now you can safely use the movie property
         let movieViewModel = MovieViewModel()
         movieViewModel.getMovie(movie_id: movie.id)
        //self.movie = movieViewModel.selectedMovie!
     }
    
    
    var body: some View {
        ZStack{
      
                
                BGView()
                ScrollView{
                    VStack{
                        
                        AsyncImage(url: movie.posterURL) { image
                            in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                        
                        
                        //MARK: TITLE
                        HStack {
                            Text(String((movie.name ?? movie.title)!)  ).font(.title).fontWeight(.bold)
                            Text("("+(String((movie.releaseDate ?? movie.firstAirDate)!.prefix(4)))+")").font(.title2)
                        }
                        
                        //MARK: GENRES
                        HStack(content: {
                            ForEach(genres, id:\.self) { genre in
                                Text(genre)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .padding()
                                    .foregroundColor(Color.themeGray)
                                    .frame(width: 120, height: 30, alignment: .center)
                                    .background{
                                        Color.black
                                    }.clipShape(Capsule())
                            }
                        })
                        
                        //MARK: OVERVIEW
                        Text(movie.overview).font(.body).padding(.horizontal).padding(.top)
                    }
                }
            
            }.ignoresSafeArea()
        
    }
    
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(){
                AsyncImage(url: movie.backdropURL) { image
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

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView(movie: Movie.example()).preferredColorScheme(.dark)
//    }
//}
