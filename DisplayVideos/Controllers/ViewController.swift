//
//  ViewController.swift
//  DisplayVideos
//
//  Created by Prabhdeep Singh on 17/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController {
    
    //MARK: Properties
    private let googleSignInView: GIDSignInButton = {
        let button = GIDSignInButton()
        button.colorScheme = GIDSignInButtonColorScheme.dark
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var coordinator: MainCoordinator?

    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        view.addSubview(googleSignInView)
        addConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            googleSignInView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            googleSignInView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    
}

extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("Error Google Signing user \(error.localizedDescription)")
            return
        }
        guard let authentication = user.authentication else {
            return
        }
        print("Signed in user \(String(describing: user.profile.givenName))")
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("Error in signing user \(error.localizedDescription)")
                return
            }
            print("User authenticated successfully",result?.user.displayName as Any)
            self.coordinator?.openVideosVc()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //something to ddo here
    }
    
    
}

