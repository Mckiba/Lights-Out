//
//  Home.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_status") var log_Status = true
    @State var searchOption = ""
    @StateObject var movieViewModel = MovieViewModel()
    @State var pushView = false
    
    
    //MARK: Animated view properties
    @State var currentIndex: Int = 0
    
    //MARK: Environment variables
    @Environment(\.colorScheme ) var scheme
    var body: some View {
        NavigationView {
            if movieViewModel.isLoading {
                ProgressView()
            } else {
                
                ZStack{
                    BGView()
                    VStack(alignment:.leading, content: {
                        
                        HStack(content: {
                            Text("Hi Alvin").fontWeight(.bold)
                                .font(.largeTitle)
                            Spacer()
                            Button(action: {
                                DispatchQueue.global(qos: .background).async {
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
                        
                        //MARK: - SEARCH
                        HStack{
                            Text("Search movies or series")
                            Spacer()
                            Image(systemName: "magnifyingglass")
                            
                        }.frame(height:8).padding()
                            .background(Color.themeGray)
                            .clipShape(RoundedRectangle(cornerRadius: 20)).padding(.horizontal)
                        
                        Text("WHAT'S TRENDING").fontWeight(.bold).padding(.horizontal)
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(movieViewModel.movieThings.results, id: \.id){ movie in
                                    NavigationLink(destination: MovieView(movie: movie)){
                                        AsyncImage(url: movie.posterURL) { image
                                            in image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .cornerRadius(15)
                                        } placeholder: {
                                            ProgressView()
                                            
                                        }.padding(.horizontal)
                                    }
                                }
                            }
                        }
                        
                     //MARK: - CATEGORIES
                        HStack(alignment: .center, spacing:10) {
                            VStack(alignment: .center, content: {
                                Text("Movies").fontWeight(.bold).font(.subheadline)
                                Image("movie").resizable().aspectRatio( contentMode: .fit)
                                    .clipShape(Circle())
                            })
                            VStack(alignment: .center, content: {
                                Text("TV Shows").fontWeight(.bold).font(.subheadline)
                                Image("tv").resizable().aspectRatio( contentMode: .fit)
                                    .clipShape(Circle())
                            })

                            VStack(alignment: .center, content: {
                                Text("People").fontWeight(.bold).font(.subheadline)
                                Image("people").resizable().aspectRatio( contentMode: .fit)
                                    .clipShape(Circle())
                            })
                        }.frame(height: 140).padding(.horizontal)
                        Spacer()
                    })
                }
            }
        }.background(Color.black)
    }
    
    @ViewBuilder
    func BGView()->some View{
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex){
                Image("homeBg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:size.width, height: size.height)
                .clipped()
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
                color,
             ], startPoint: .top, endPoint: .bottom)
            
            //MARK: Blurred overlay
            Rectangle()
                .fill(.ultraThinMaterial)
        }.ignoresSafeArea()
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
