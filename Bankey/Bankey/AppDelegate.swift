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
    let mainViewController = MainViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
                
        displayLogin()
    
        registerForNotifications()
        return true
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    private func displayNextScreen() {
        if LocalState.isOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        }
        else {
            setRootViewController(onboardingContainerViewController)
        }
    }
    private func prepMainView() {
        
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    
    func didLogIn() {
        displayNextScreen()
    }
}

extension AppDelegate: OnboardingContrainerViewControllerDelegate {
    
    func didFinishOnboarding() {
        
        LocalState.isOnboarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

extension AppDelegate {
    
    private func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
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
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}
