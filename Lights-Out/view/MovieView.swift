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
    
    init(movie: Movie) {
         self.movie = movie
        movieViewModel.getMovie(movie_id: movie.id)
        movieViewModel.getMovieCasting(movie_id: movie.id)
        switch movie.mediaType {
        case "tv":
            movieViewModel.getTVCasting(tv_id: movie.id)
        default:
            movieViewModel.getMovieCasting(movie_id: movie.id)
        }
    }
    
    var body: some View {
        ZStack{
            
            BGView()
            
            Image(systemName: "play.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 20, idealWidth: 40, maxWidth: 40, minHeight: 20, idealHeight: 40, maxHeight: 40, alignment: .top)
                .foregroundColor(Color.themeGray)
                .offset(y: -235).opacity(0.8)
            
            ScrollView(.vertical){
                VStack {
                    Text((movie.originalName ?? movie.title)!).font(.largeTitle)
                        .font(.custom("Montserrat-Bold",size:12))
                        .fontWeight(.bold)
                    
                    HStack{
                        Text((String((movie.releaseDate ?? movie.firstAirDate)!.prefix(4))))
                        Image(systemName: "circle.fill").font(.system(size:8))
                        
                        //ForEach((movieViewModel.selectedMovie?.genres?.prefix(3))!, id:\.id) { genre in
                        ForEach(movie.testGenres, id:\.id) { genre in //debug
                            Text(genre.name+",")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        Image(systemName: "circle.fill").font(.system(size:8))
                        //Text("\((movieViewModel.selectedMovie?.runtime!)!/60 )h")
                        //Text("\((movieViewModel.selectedMovie?.runtime)! % 60)m")
                        Text("1h") //debug
                        Text("42m")//debug
                    }.foregroundColor(Color.themeGray).padding(.top,1)
                    
                    //shows the rating in stars 0 - 5
                    StarFill(rating: Int(movie.voteAverage)).padding(.top,1)
                    
                    //MARK: - MOVIE OVERVIEW
                    VStack(alignment: .leading, content: {
                        if #available(iOS 16.0, *) {
                            Text("Plot Summary").padding().font(.headline)                        .font(.custom("Montserrat-Regular",size:12))
                                .fontWeight(.bold)
                        } else {
                            Text("Plot Summary").padding().font(.headline)                        .font(.custom("Montserrat-Regular",size:12))
                        }
                        Text(movie.overview).font(.body).padding(.horizontal).font(.body)
                        if #available(iOS 16.0, *) {
                            Text("Cast").padding().font(.headline).fontWeight(.bold)
                                .font(.custom("Montserrat-Regular",size:12))
                        } else {
                            Text("Cast").padding().font(.headline)
                        }
                        
                        //MARK: - CASTING
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                //ForEach(movieViewModel.casting.cast, id:\.id) { cast in
                                ForEach(Cast.loadJson()!, id:\.id) { cast in //debug
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
                                            .fixedSize(horizontal: false, vertical: true)
                                        Text(cast.character ?? cast.name).font(.subheadline).lineLimit(3)
                                    }.frame(width: 120)
                                }.padding(.trailing)
                            }
                        }.padding(.horizontal)
                        //MARK: - SIMMILAR MOVIES
                        Text("Simmilar movies").padding().font(.headline)
                        
                    })
                }
            }
            .offset(x: 0.0, y: 300.0)
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
                color,color,color,
                color
            ], startPoint: .top, endPoint: .bottom)
        }.ignoresSafeArea()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie.example()).preferredColorScheme(.dark)
    }
}
