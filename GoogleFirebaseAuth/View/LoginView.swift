//
//  LoginView.swift
//  GoogleFirebaseAuth
//
//  Created by Samsul Hadi on 15/11/21.
//

import SwiftUI
import Firebase
import FirebaseAuthUI
import FirebaseOAuthUI
import FirebaseGoogleAuthUI

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

struct LoginView: View {
    
    @State private var viewState = CGSize(width: 0, height: screenHeight)
    @State private var MainviewState = CGSize.zero
    
    var body: some View {
        
        ZStack {
            CustomLoginViewController { (error) in
                if error == nil {
                    self.status()
                }
            }
        }
    }
    
    func status() {
        self.viewState = CGSize(width: 0, height: 0)
        self.MainviewState = CGSize(width: 0, height: screenHeight)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CustomLoginViewController : UIViewControllerRepresentable {
    
    var dismiss : (_ error : Error? ) -> Void
    
    func makeCoordinator() -> CustomLoginViewController.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController
    {
        let authUI = FUIAuth.defaultAuthUI()
        
        let googleProvider = FUIGoogleAuth(authUI: authUI!)
        
        let appleProvider = FUIOAuth.appleAuthProvider(withAuthUI: authUI!)

        authUI?.providers = [googleProvider, appleProvider]
        authUI?.delegate = context.coordinator
        
        let authViewController = authUI?.authViewController()

        return authViewController!
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomLoginViewController>)
    {
        
    }
    
    //coordinator
    class Coordinator : NSObject, FUIAuthDelegate {
        var parent : CustomLoginViewController
        
        init(_ customLoginViewController : CustomLoginViewController) {
            self.parent = customLoginViewController
        }
        
        // MARK: FUIAuthDelegate
        func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?)
        {
            if let error = error {
                parent.dismiss(error)
            }
            else {
                parent.dismiss(nil)
            }
        }
        
        func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?)
        {
        }
    }
}
