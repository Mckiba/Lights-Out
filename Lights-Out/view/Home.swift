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
                    Text("Where would you like to go?")
                }).padding(.trailing)
                Spacer()
                VStack(alignment: .center,content : {
                    Image(systemName: "person.crop.circle.fill").frame(height: 30)
                        .font(.system(size: 35))
                    Button(action: {
                        DispatchQueue.global(qos: .background).async {
                            try? Auth.auth().signOut()
                        }
                        withAnimation(.easeInOut){
                            log_Status = false
                        }
                    }, label: {
                        
                        Text("Log Out")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
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
            
            
            Text("Explore").font(.largeTitle).fontWeight(.bold).padding(.horizontal)
            
            HStack(alignment: .center, content: {
                VStack(alignment: .center, content: {
                    Image(systemName: "airplane.circle").font(.system(size: 60)).foregroundColor(Color.gray)
                    Text("Movies")
                }).padding(.leading,20)
                
                VStack(alignment: .center, content: {
                    Image(systemName: "bed.double.circle").font(.system(size: 60)).foregroundColor(Color.gray)
                    Text("TV-Series")
                })
                
                VStack(alignment: .center, content: {
                    Image(systemName: "car.circle").font(.system(size: 60)).foregroundColor(Color.gray)
                    Text("Anime")
                })
                
                VStack(alignment: .center, content: {
                    Image(systemName: "doc.circle").font(.system(size: 60)).foregroundColor(Color.gray)
                    Text("People")
                })
            }).padding()
            
            HStack(alignment: .center, content: {
                Text("Trending").font(.headline).padding()
                Spacer()
                Text("See All >").padding()
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
                            Text(movie.originalTitle ??  "Coming Soon").fontWeight(.bold)
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
