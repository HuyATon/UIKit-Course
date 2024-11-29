//
//  AppDelegate.swift
//  Bankey
//
//  Created by Huy Ton Anh on 27/11/2024.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        let vc = mainViewController
        vc.setStatusBar()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc

        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    
    func didLogIn() {
        setRootViewController(LocalState.isOnboarded ? mainViewController : onboardingContainerViewController)
    }
}

extension AppDelegate: OnboardingContrainerViewControllerDelegate {
    
    func didFinishOnboarding() {
        
        setRootViewController(mainViewController)
        LocalState.isOnboarded = true
    }
}

extension AppDelegate {
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        
        guard animated, let window = self.window else {
            
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
    
    
}
