//
//  AccountSummaryView.swift
//  Bankey
//
//  Created by Huy Ton Anh on 28/11/2024.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    let shakeyBellView = ShakeyBellView()
    
    struct ViewModel {
        
        let welcomeMessange: String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    private func commonInit() {
        
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        setupShakeyBellView()
    }
    
    private func setupShakeyBellView() {
        
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shakeyBellView)
        
        NSLayoutConstraint.activate([
            shakeyBellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            shakeyBellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(viewModel: ViewModel) {
        
            self.welcomeLabel.text = viewModel.welcomeMessange
            self.nameLabel.text = viewModel.name
            self.dateLabel.text = viewModel.dateFormatted
        
    }
}
