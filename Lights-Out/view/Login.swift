//
//  Login.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 8/1/22.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseAuth

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    var body: some View {
        
        
        ZStack{
            Image("background4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            VStack(spacing: 25, content: {
                Text("Lights Out")
                    .font(.custom("Noteworthy-Bold",size:24))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity,alignment:  .center)
                    .padding()
                    .offset(y:15)
                    .padding(.vertical,20)
                
                Spacer()
                VStack(alignment: .center,spacing: 33, content: {

                    HStack{
                        Image("apple").resizable()
                            .frame(width: 16, height: 19)
                        Text("CONTINUE WITH APPLE").font(.custom("Montserrat-Bold", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .tracking(0.5)
                    }                    .frame(width: 327, height: 44)
               
                        .background(Color.black)
                    .overlay{
                        SignInWithAppleButton{ (request) in
                            loginData.nonce = randomNonceString()
                            request.requestedScopes = [.email,.fullName]
                            request.nonce = sha256(loginData.nonce)
                        } onCompletion: { (result) in
                            switch(result){
                            case .success(let user):
                                print("success")
                                //do login with firebase
                                guard let credential = user.credential as?
                                        ASAuthorizationAppleIDCredential else {
                                    print("Error with firebase")
                                    return
                                }
                                loginData.authenticate(credential: credential)
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .signInWithAppleButtonStyle(.black)
                         .blendMode(.overlay)
                    }
                    .clipped()
                    
              
                    
                    
                    HStack{
                        Image("google").resizable()
                            .frame(width: 24, height: 24)
                        Text("CONTINUE WITH GOOGLE").font(.custom("Montserrat-Bold", size: 12))
                            .fontWeight(.bold)
                            .tracking(0.5)
                     }
                    .frame(width: 327, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 60)).foregroundColor(Color.black)                    .background(Color.white)
                    .foregroundColor(.white)
                    .overlay{
                        GoogleSignInButton{
                            loginData.handleLogin()
                        }.frame(width: 120)
                        .blendMode(.overlay)
                    }
                    .clipped()
                    
                  
 
                    //SIGN UP WITH EMAIL
                    Button(action: {}, label: {
                        if #available(iOS 16.0, *) {
                            Text("SIGN UP WITH EMAIL")
                                .font(.custom("Montserrat-Bold",size:12))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 327.0, height: 44.0)
                                .fontWeight(.bold)
                        } else {
                            // Fallback on earlier versions
                            Text("SIGN UP WITH EMAIL")
                                .font(.custom("Montserrat-Bold",size:12))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 327.0, height: 44.0)
                         }
                    })
                    .cornerRadius(20)
                    .buttonBorderShape(.roundedRectangle)
                    .background(Color.themeGray)
                })
                
                Text("By continuing, you agree to accept our\nPrivacy Policy & Terms of Service")
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .font(.custom("Montserrat-Regular.", size: 12))
                Spacer()
            })
        }
    }
}
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

