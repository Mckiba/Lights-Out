//
//  Home.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_status") var log_Status = false
    
    @State var searchOption = ""
    @StateObject var movieViewModel = MovieViewModel()
    
    var body: some View {
        
        VStack(alignment: .center,content: {
            
            HStack(content: {
                VStack(alignment:.leading,content: {
                    Text("Hi Alvin").fontWeight(.bold)
                        .font(.largeTitle)
                }).padding(.trailing)
                Spacer()
                VStack(alignment: .center,content : {
                                        Button(action: {
                                            DispatchQueue.global(qos:                                           .background).async {
                                                try? Auth.auth().signOut()
                                            }
                                            withAnimation(.easeInOut){
                                                log_Status = false
                                            }
                                        }, label: {
                                            Image(systemName: "person.crop.circle.fill").frame(height: 30)
                                                .font(.system(size: 35))
                                        })
                }).padding(.horizontal)
            }).padding(.horizontal)
            
            HStack{
                Text("Search")
                Spacer()
                Image(systemName: "magnifyingglass")
                
            }.frame(height:8).padding()
                .background(Color.themeGray)
                .clipShape(RoundedRectangle(cornerRadius: 20)).padding(.horizontal)
            
            HStack( content:  {
                Text("Explore").font(.largeTitle).fontWeight(.bold).padding(.horizontal)
                Spacer()
            })
            
            HStack(alignment: .center, spacing:20, content: {
                VStack(alignment: .center, content: {
                    Image("movie").resizable().aspectRatio( contentMode: .fit)
                        .clipShape(Circle())
                    Text("Movies").fontWeight(.bold)
                })
                VStack(alignment: .center, content: {
                    Image("tv").resizable().aspectRatio( contentMode: .fit)
                        .clipShape(Circle())
                    Text("TV Shows").fontWeight(.bold)
                })
                
                VStack(alignment: .center, content: {
                    Image("people").resizable().aspectRatio( contentMode: .fit)
                        .clipShape(Circle())
                    Text("People").fontWeight(.bold)
                })
            }).frame(height: 150)
            
            HStack(alignment: .center, content: {
                Text("Trending").font(.headline).padding()
                Spacer()
                Text("See All").padding()
            })
            
            ScrollView(.horizontal,content: {
                HStack(alignment: .center, content: {
                    ForEach(movieViewModel.movieThings.results, id: \.self) { movie in
                        VStack(alignment:.center, content: {
                            AsyncImage(url: movie.posterURL) { image
                                in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(movie.originalTitle ?? movie.originalName ?? "Coming Soon").fontWeight(.bold)
                        }).padding(.horizontal,10)
                    }
                }).padding(.leading)
            })
            Spacer()
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
