import Foundation

class API {
    
    static func url(_ path: String) -> String {
        return Settings.backendHost + path
    }
    
}
