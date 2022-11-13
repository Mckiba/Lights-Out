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
    
    
    let sampleData = ["COlumbus", "Cleveland", "Miami"]
    
    var results: [String] {
        if (searchOption.isEmpty){
            return sampleData
        }else{
            return sampleData.filter{$0.contains(searchOption)}
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading,content: {
            
            HStack(alignment: .center, content: {
                VStack(alignment:.leading,content: {
                    Text("Hi Tester").fontWeight(.bold)
                        .font(.largeTitle)
                }).padding(.trailing)
                Spacer()
                VStack(alignment: .center,content : {
                    Image(systemName: "person.crop.circle.fill").frame(height: 30)
                        .font(.system(size: 35))
//                    Button(action: {
//                        DispatchQueue.global(qos: .background).async {
//                            try? Auth.auth().signOut()
//                        }
//                        withAnimation(.easeInOut){
//                            log_Status = false
//                        }
//                    }, label: {
//                        Text("Log Out")
//                            .foregroundColor(Color.black)
//                            .fontWeight(.semibold)
//                    })
                }).padding(.horizontal)
            }).padding(.horizontal)
               
            HStack{
                Text("Search")
                 Spacer()
                Image(systemName: "magnifyingglass")
                
            }.frame(height:8).padding()
                .background(Color.themeGray)
                .clipShape(RoundedRectangle(cornerRadius: 20)).padding(.horizontal)
            
            
            Text("Explore").font(.largeTitle).fontWeight(.bold).padding(.horizontal)
            
            HStack(alignment: .center, spacing:20, content: {
                VStack(alignment: .center, content: {
                    Image("movie").resizable().aspectRatio( contentMode: .fit)
                        .clipShape(Circle())
                        
                      
                    Text("Movies")
                })
                VStack(alignment: .center, content: {
                    Image("tv").resizable().aspectRatio( contentMode: .fit)
                        .clipShape(Circle())
                       
                      
                    Text("TV Shows")
                })
                
                VStack(alignment: .center, content: {
                    Image("tv").resizable().aspectRatio( contentMode: .fit)
                        .clipShape(Circle())
                      
                    Text("People")
                })
                
          
            })
            
            HStack(alignment: .center, content: {
                Text("Trending").font(.headline).padding()
                Spacer()
                Text("See All").padding()
            })
            
            ScrollView(.horizontal,content: {
                HStack(alignment: .center, content: {
                    ForEach(movieViewModel.movieThings.results, id: \.self) { movie in
                        VStack( content: {
                            AsyncImage(url: movie.posterURL) { image
                                in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(movie.originalTitle ??  "Coming Soon").fontWeight(.bold).lineLimit(nil)
                        })
                    }
                }).padding(.horizontal)
                
            })
            
            
          
          
            
            Spacer()

            
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
