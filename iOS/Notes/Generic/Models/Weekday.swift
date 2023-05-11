//  Created by Denis Malykh on 17.04.2023.

import Foundation

struct Weekday : OptionSet {
    let rawValue: Int

    static let monday    = Weekday(rawValue: 1 << 0)
    static let tuesday   = Weekday(rawValue: 1 << 1)
    static let wednesday = Weekday(rawValue: 1 << 2)
    static let thursday  = Weekday(rawValue: 1 << 3)
    static let friday    = Weekday(rawValue: 1 << 4)
    static let saturday  = Weekday(rawValue: 1 << 5)
    static let sunday    = Weekday(rawValue: 1 << 6)

    static let weekend: Weekday  = [.saturday, .sunday]
    static let weekdays: Weekday = [.monday, .tuesday, .wednesday, .thursday, .friday]
    static let whole: Weekday = weekdays.union(weekend)
}

extension Weekday {
    var isWholeWeek: Bool {
        return self == .whole
    }

    var isWeekend: Bool {
        return self == .weekend
    }

    var isWeekdays: Bool {
        return self == .weekdays
    }
}

extension Weekday {
    var localized: String {
        if isWholeWeek {
            return l10n.Weekday.whole
        }
        if isWeekend {
            return l10n.Weekday.end
        }
        if isWeekdays {
            return l10n.Weekday.days
        }
        var items = [String]()
        if self.contains(.monday) {
            items.append(l10n.Weekday.mon)
        }
        if self.contains(.tuesday) {
            items.append(l10n.Weekday.tue)
        }
        if self.contains(.wednesday) {
            items.append(l10n.Weekday.wed)
        }
        if self.contains(.thursday) {
            items.append(l10n.Weekday.thu)
        }
        if self.contains(.friday) {
            items.append(l10n.Weekday.fri)
        }
        if self.contains(.saturday) {
            items.append(l10n.Weekday.sat)
        }
        if self.contains(.sunday) {
            items.append(l10n.Weekday.sun)
        }
        return items.joined(separator: ", ")
    }
}
