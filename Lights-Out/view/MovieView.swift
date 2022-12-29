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
        movieViewModel.getSimilarMovies(movie_id: movie.id)
        
        switch movie.mediaType {
        case "tv":
            movieViewModel.getTVCasting(tv_id: movie.id)
        default:
            movieViewModel.getMovieCasting(movie_id: movie.id)
        }
    }
    
    var body: some View {
        ZStack(alignment: .center){
            BGView()
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    Text((movie.originalName ?? movie.title)!).font(.largeTitle)
                        .font(.custom("Montserrat-Bold",size:12))
                        .fontWeight(.bold)
                    
                    HStack{
                        Text((String((movie.releaseDate ?? movie.firstAirDate)!.prefix(4))))
                        Image(systemName: "circle.fill").font(.system(size:8))
                        
                        ForEach((movieViewModel.selectedMovie?.genres?.prefix(2))!, id:\.id) { genre in
                            Text(genre.name+",")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        Image(systemName: "circle.fill").font(.system(size:8))
                        Text("\((movieViewModel.selectedMovie?.runtime!)!/60 )h")
                        Text("\((movieViewModel.selectedMovie?.runtime)! % 60)m")
                        
                    }.foregroundColor(Color.themeGray).padding(.top,1)
                    
                    HStack {
                        StarFill(rating: Int(movie.voteAverage)).padding(.vertical,1)
                        Text("\(movie.voteAverage , specifier: "%.1f")")
                    }.foregroundColor(.yellow)
                    
                    //MARK: -   OVERVIEW
                    VStack(alignment: .leading, content: {
                        if #available(iOS 16.0, *) {
                            Text("Plot Summary").font(.headline)
                                .font(.custom("Montserrat-Regular",size:12))
                                .fontWeight(.bold)
                        } else {
                            Text("Plot Summary").padding().font(.headline)
                                .font(.custom("Montserrat-Regular",size:12))
                        }
                        Text(movie.overview).font(.body).padding(.vertical,5).font(.body)
                        
                        //MARK: - CASTING
                        if #available(iOS 16.0, *) {
                            Text("Cast").font(.headline).fontWeight(.bold)
                                .font(.custom("Montserrat-Regular",size:12))
                        } else {
                            Text("Cast").font(.headline)
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(movieViewModel.casting.cast, id:\.id) { cast in
                                    VStack(alignment: .leading) {
                                        AsyncImage(url: cast.profileURL) { image
                                            in image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        Text(cast.name).font(.system(size: 13))
                                            .fixedSize(horizontal: false, vertical: true)
                                        Text(cast.character ?? cast.name).font(.subheadline).lineLimit(3)
                                    }.frame(width: 100,alignment: .leading)
                                }.padding(.trailing)
                            }
                        }.padding(.horizontal)
                        
                        //MARK: - SIMMILAR MOVIES
                        Text("Simmilar movies").font(.headline)
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:5){
                                ForEach(movieViewModel.similarMovies.results, id: \.id){ movie in
                                    NavigationLink(destination: MovieView(movie: movie)){
                                        VStack{
                                            AsyncImage(url: movie.posterURL) { image
                                                in image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame( height: 200)
                                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                            } placeholder: {
                                                ProgressView()
                                                
                                            }.padding(.horizontal)
                                            Text((movie.originalName ?? movie.title)!).font(.system(size: 13))
                                                .fixedSize(horizontal: false, vertical: true).lineLimit(3).foregroundColor(.white)
                                        }.frame(alignment: .center)
                                    }
                                }
                            }
                        }
                    })
                }
            }.offset(y:200).padding(.bottom,200).padding(.horizontal)
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
                color,color
            ], startPoint: .top, endPoint: .bottom)
        }.ignoresSafeArea()
    }
}

