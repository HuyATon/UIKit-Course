//
//  AccountSummaryCellViewController+EXt.swift
//  Bankey
//
//  Created by Huy Ton Anh on 06/12/2024.
//

import Foundation


enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
}

struct Account: Codable {
    
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
}


extension AccountSummaryViewController {
    
    func fetchProfile(forUserId userId: String, completion: @escaping(Result<Profile, NetworkError>) -> Void) {
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
        URLSession.shared.dataTask(with: url) { data, res, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let profile = try decoder.decode(Profile.self, from: data)
                    completion(.success(profile))
                }
                catch {
                    completion(.failure(.decodingError))
                }
            }
        }
        .resume()
    }
}



