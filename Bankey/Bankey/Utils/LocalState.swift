//
//  LocalState.swift
//  Bankey
//
//  Created by Huy Ton Anh on 28/11/2024.
//

import Foundation


public class LocalState {
    
    private enum Keys: String {
        case isOnboarded
    }
    
    public static var isOnboarded: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: Keys.isOnboarded.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isOnboarded.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
