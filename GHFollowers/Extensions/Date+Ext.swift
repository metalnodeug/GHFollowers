//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by metalnodeug on 04/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
