//
//  UIView+DateFormatters.swift
//  YFF2016
//
//  Created by Isaac Norman on 1/4/18.
//  Copyright © 2018 Yackandandah Folk Festival. All rights reserved.
//

import Foundation

func getDayOfWeek(_ today:String) -> Int? {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formatter.date(from: today) else { return nil }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    return weekDay
}
