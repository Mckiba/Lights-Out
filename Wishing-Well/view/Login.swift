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

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    var body: some View {
        
        
        ZStack{
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            VStack(spacing: 25, content: {
                Text("wishing well")
                    .font(.custom("Noteworthy-Bold",size:24))
                    .fontWeight(.bold)
                    .foregroundColor(.themeColor)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity,alignment:  .center)
                    .padding()
                    .offset(y:15)
                    .padding(.vertical,20)
                
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 198, height: 260)
                
                Spacer()
                VStack(alignment: .center,spacing: 33, content: {

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
                    .frame(width: 327.0, height: 44)
                    
                    
                    GoogleSignInButton{
                        
                    }.frame(width: 327.0,height: 44)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
 
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
                
                Text("By continuing, you agree to accept our")
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .font(.custom("Montserrat-Regular.", size: 12))
                    
                Text("Privacy Policy & Terms of Service")
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .font(.custom("Montserrat-Regular.", size: 12))
                    .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-20.0/*@END_MENU_TOKEN@*/)
                    
 
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

