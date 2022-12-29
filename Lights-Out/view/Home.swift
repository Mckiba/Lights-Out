//
//  Home.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @State var searchOption = ""
    @State var pushView = false
    @State var isPresenting: Bool = false
    @StateObject var movieViewModel = MovieViewModel()
    @StateObject var loginController = LoginViewModel()
    @StateObject var loginInfo = LoginViewModel()
    @AppStorage("log_status") var log_Status = true
    @AppStorage("user_name") var user_name = "User"
    @AppStorage("profile_photo") var profile_photo = ""


    
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
                            Text("Hi \(user_name)").fontWeight(.bold)
                                .font(.largeTitle)
                            Spacer()
                            Button(action: {
                                isPresenting = true
                            }, label: {
                                AsyncImage(url: URL(string: profile_photo)) { image in
                                    image
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:30, height: 30)
                                        .clipShape(Circle())
                                }placeholder: {
                                    Image(systemName: "person.crop.circle.fill").frame(height: 30).font(.system(size: 35))
                                }
                            }).alert(isPresented: $isPresenting){
                                
                                Alert(
                                    title:Text("Sign Out"),
                                    message: Text("Are you sure you want to sign Out?"),
                                    primaryButton: .default(
                                        Text("Sign Out"),
                                        action: {loginController.handleSignOut()}
                                    ),
                                    secondaryButton: .destructive(Text("Cancel"),action: {isPresenting = false})
                                )
                            }
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
                        
                        //MARK: - MOVIES SHOWCASE
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(movieViewModel.trendingMovies.results, id: \.id){ movie in
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
                        }.padding(.bottom)
                        
                     //MARK: - CATEGORIES
                        Categories()
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
                //.black,
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
        Home().preferredColorScheme(.dark)
    }
}
