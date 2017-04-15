import Foundation

class Format {
    
    static func dollars(_ cents: Int) -> String {
        if cents % 100 == 0 {
            return "$\(cents / 100)"
        } else {
            return String(format: "$%02d", Double(cents) / 100.0)
        }
    }
    
}
