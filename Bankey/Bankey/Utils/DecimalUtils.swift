//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Huy Ton Anh on 29/11/2024.
//

import Foundation

extension Decimal {
    
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
    
}
