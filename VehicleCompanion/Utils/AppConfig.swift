//
//  AppConfig.swift
//  VehicleCompanion
//

import Foundation

enum ConfigSettings: String {
    case tripIdeasURL = "TRIP_IDEAS_URL"
}

enum Environment: String {
    case debug
    case release
    
    var plistFileName: String {
        switch self {
        case .debug:
            return "DebugSettings"
        case .release:
            return "ReleaseSettings"
        }
    }
}

class AppConfig {
    private var environment: Environment = .debug
    
    private init() {
        assignEnvironment()
    }
    
    static var tripIdeasURL: String? {
        AppConfig().getStringConfig(for: .tripIdeasURL)
    }
    
    // MARK: - Helper methods
    private func getStringConfig(for property: ConfigSettings) -> String? {
        if let path = Bundle.main.path(forResource: environment.plistFileName, ofType: "xcconfig"),
           let xml = FileManager.default.contents(atPath: path),
           let config = try? PropertyListDecoder().decode([String: String].self, from: xml) {
            return config[property.rawValue]
        }
        return nil
    }
    
    private func assignEnvironment() {
#if DEBUG
        environment = .debug
#elseif RELEASE
        environment = .release
#else
        environment = .debug
#endif
    }
}
