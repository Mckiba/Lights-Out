//
//  MovieView.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/17/22.
//

import SwiftUI

struct MovieView: View {
    let movie : Movie
    @Environment(\.colorScheme ) var scheme
    
    let genres: [String] = ["Action", "Romance", "Love"]
    
    var body: some View {
        ZStack{
            BGView()
            ScrollView{
                VStack{
                    AsyncImage(url: movie.posterURL) { image
                        in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .infinity, height: 400)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                    HStack {
                        Text(movie.name!).font(.title).fontWeight(.bold)
                        Text("("+(String((movie.releaseDate ?? movie.firstAirDate)!.prefix(4)))+")").font(.title2)
                    }.padding(.vertical)
                    Text(movie.overview).font(.body).padding(.horizontal)
                    
                    
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
                    }).padding(.top)
                }
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
