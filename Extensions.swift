//
//  Extensions.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 16/05/23.
//

import Foundation


//MARK: - DATE
extension Date{
    
    var mezzanotte: Date{
        let cal = Calendar(identifier: .gregorian)
        return cal.startOfDay(for: self)
        
    }
}
