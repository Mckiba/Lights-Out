//
//  Login.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 8/1/22.
//

import SwiftUI
import AuthenticationServices

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
                    
                    
                    //CONTINUE WITH GOOGLE
                    Button(action: {}, label: {
                        if #available(iOS 16.0, *) {
                            Text("CONTINUE WITH GOOGLE")
                                .font(.custom("Montserrat-Bold",size:12))
                                .foregroundColor(Color.themeGray)
                                .multilineTextAlignment(.center)
                                .frame(width: 327.0, height: 44.0)
                                .fontWeight(.bold)
                                .border(Color.themeGray)

                        } else {
                            // Fallback on earlier versions
                            Text("CONTINUE WITH GOOGLE")
                                .font(.custom("Montserrat-Bold",size:12))
                                .foregroundColor(Color.themeGray)
                                .multilineTextAlignment(.center)
                                .frame(width: 327.0, height: 44.0)
                                .border(Color.themeGray)
                         }
                    })
                    .buttonBorderShape(.roundedRectangle)
 
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

