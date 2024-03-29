//
//  loginViewModel.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import Foundation
import CryptoKit
import AuthenticationServices
import Firebase
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

class LoginViewModel: ObservableObject {
    
    @Published var nonce = ""
    @AppStorage("log_status") var log_Status = false
    @AppStorage("user_name") var user_name = ""
    @AppStorage("profile_photo") var profile_photo = ""
    
    //MARK: - GOOGLE SIGN IN
    func handleGoogleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewCOntroller()) {[self] user, error in
            
            if let error = error { print(error.localizedDescription)
                return
            }
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken
                else {return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { [self] signInResult,err in
                
                if let error = err{
                    print(error.localizedDescription)
                    return
                }
                guard let result = signInResult?.user else {return}
                let fullName = result.displayName!
                
                if let spaceIndex = fullName.firstIndex(of: " "){
                    let firstString = String(fullName[..<spaceIndex])
                    user_name = firstString
                }
                
                profile_photo = result.photoURL!.absoluteString
                print("logged in Success")//logged in
                withAnimation(.easeInOut){
                    self.log_Status = true
                }
            }
        }
    }
    
    //MARK: - HANDLE SIGN OUT
    func handleSignOut(){
        DispatchQueue.global(qos: .background).async {
            try? Auth.auth().signOut()
        }
        withAnimation(.easeInOut){
            log_Status = false
        }
    }
    
    //MARK: - APPLE SIGN IN
    func appleAuthenticate(credential: ASAuthorizationAppleIDCredential ){
        
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with token")
            return
        }
        let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: credential) {result ,err in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            print("logged in Success")//logged in
            withAnimation(.easeInOut){
                self.log_Status = true
            }
        }
    }
    
    
    func getRootViewCOntroller()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    
}

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
     return result
}
