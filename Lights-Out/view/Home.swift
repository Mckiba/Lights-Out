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
    
    //MARK: Animated view properties
    @State var currentIndex: Int = 0
    
    
    //MARK: Environment variables
    @Environment(\.colorScheme ) var scheme
    var body: some View {
        
        ZStack{
            BGView()
            VStack(alignment: .center,content: {
                
                HStack(content: {
                    Text("Hi Alvin").fontWeight(.bold)
                        .font(.largeTitle)
                    Spacer()
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
                
                //MARK: SEARCH
                HStack{
                    Text("Search")
                    Spacer()
                    Image(systemName: "magnifyingglass")
                    
                }.frame(height:8).padding()
                    .background(Color.themeGray)
                    .clipShape(RoundedRectangle(cornerRadius: 20)).padding(.horizontal)
                
                HStack(alignment: .center, content: {
                    Text("Trending").font(.headline).padding()
                    Spacer()
                })
                
                
                SnapCarousel(spacing: 20,trailingSpace: 110, index: $currentIndex, items: movieViewModel.movieThings.results){
                    movie in
                    
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        AsyncImage(url: movie.posterURL) { image
                            in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:size.width, height: size.height)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                    }.padding(.top,26)
                }
                
                
                //MARK: CATEGORIES
                HStack(alignment: .center, spacing:10, content: {
                    VStack(alignment: .center, content: {
                        Text("Movies").fontWeight(.bold)
                        Image("movie").resizable().aspectRatio( contentMode: .fit)
                            .clipShape(Circle())
                    })
                    VStack(alignment: .center, content: {
                        Text("TV Shows").fontWeight(.bold)
                        Image("tv").resizable().aspectRatio( contentMode: .fit)
                            .clipShape(Circle())
                    })
                    
                    VStack(alignment: .center, content: {
                        Text("People").fontWeight(.bold)
                        Image("people").resizable().aspectRatio( contentMode: .fit)
                            .clipShape(Circle())
                    })
                }).frame(height: 150)
                
                
                /*ScrollView(.horizontal,content: {
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
                 })*/
                //Spacer()
            })
        }
    }
    
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex){
                ForEach(movieViewModel.movieThings.results, id: \.self) { movie in
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
            Rectangle()
                .fill(.ultraThinMaterial)
        }.ignoresSafeArea()
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
