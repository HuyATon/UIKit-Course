//
//  AppDelegate.swift
//  Bankey
//
//  Created by Huy Ton Anh on 27/11/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
//        window?.rootViewController = LoginViewController()

        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        window?.rootViewController = onboardingContainerViewController

        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    
    func didLogIn() {
        print("Did login")
    }
}

extension AppDelegate: OnboardingContrainerViewControllerDelegate {
    
    func didFinishOnboarding() {
        print("Did finish onboarding")
    }
}

