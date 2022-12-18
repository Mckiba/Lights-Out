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
                    .offset(y:15)
                    .padding(.vertical,20)
                
                Spacer(minLength: 300)
                
                VStack(alignment: .center,spacing: 33, content: {
                    HStack{
                        Image(systemName: "apple.logo").aspectRatio( contentMode: .fit).font(.system(size: 20))
                        Text("CONTINUE WITH APPLE").font(.custom("Montserrat-Bold", size: 12))
                            .fontWeight(.bold)
                            .tracking(0.5)
                    }
                    .frame(width: 327, height: 44)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .foregroundColor(Color.white)
                    .overlay{
                        SignInWithAppleButton{ (request) in
                            loginData.nonce = randomNonceString()
                            request.requestedScopes = [.email,.fullName]
                            request.nonce = sha256(loginData.nonce)
                        } onCompletion: { (result) in
                            switch(result){
                            case .success(let user):
                                print("success")
                                //MARK: do login with firebase
                                guard let credential = user.credential as?
                                        ASAuthorizationAppleIDCredential else {
                                    print("Error with firebase")
                                    return
                                }
                                loginData.appleAuthenticate(credential: credential)
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .signInWithAppleButtonStyle(.white)
                        .frame(width: 120)
                        .blendMode(.overlay)
                    }
                    
                    HStack{
                        Image("google").resizable()
                            .frame(width: 24, height: 24)
                        Text("CONTINUE WITH GOOGLE").font(.custom("Montserrat-Bold", size: 12))
                            .fontWeight(.bold)
                            .tracking(0.5)
                    }
                    .frame(width: 327, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .foregroundColor(Color.black)
                    .overlay{
                        GoogleSignInButton{
                            loginData.handleGoogleLogin()
                        }.frame(width: 120)
                            .blendMode(.overlay)
                    }
                    
                    //MARK: SIGN UP WITH EMAIL
                    HStack{
                        Button(action: {}, label: {
                            if #available(iOS 16.0, *) {
                                Image(systemName: "envelope")
                                Text("SIGN UP WITH EMAIL")
                                    .font(.custom("Montserrat-Bold",size:12))
                                    .fontWeight(.bold)
                            } else {
                                // Fallback on earlier versions
                                Image(systemName: "envelope")
                                Text("SIGN UP WITH EMAIL")
                                    .font(.custom("Montserrat-Bold",size:12))
                                    .multilineTextAlignment(.center)
                            }
                        })
                    }
                    .frame(width: 327, height: 44)
                    .background(Color.themeGray)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .foregroundColor(Color.white)
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

