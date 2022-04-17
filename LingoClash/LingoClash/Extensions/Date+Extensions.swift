//
//  Date+Extensions.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 17/4/22.
//

import Foundation

extension Date {

    static func - (recent: Date, previous: Date) -> Interval {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return Interval(month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    func isToday() -> Bool {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let components = DateComponents(hour: 23, minute: 59, second: 59)
        let endOfToday = Calendar.current.date(byAdding: components, to: startOfToday)
        guard let endOfToday = endOfToday else {
            return false
        }

        return self >= startOfToday && self <= endOfToday
    }
}

struct Interval {
    let month: Int?
    let day: Int?
    let hour: Int?
    let minute: Int?
    let second: Int?
}
