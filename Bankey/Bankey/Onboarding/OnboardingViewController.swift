//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Huy Ton Anh on 27/11/2024.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView =  UIImageView()
    let label = UILabel()
    
    let heroImageName: String
    let titleText: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnboardingViewController {
    
    func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // Image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: self.heroImageName)
        
        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = false
        label.text = self.titleText
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
    }
    
    func layout() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
        

    }
}
