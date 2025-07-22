import Foundation
import SwiftUI

// MARK: - App Strings
struct AppStrings {
    
    // MARK: - Icons
    struct Icons {
        static let checkmark = "checkmark"
    }
    
    // MARK: - Titles
    struct Titles {
        static let selectMember = "Select Member"
    }
}

// MARK: - App Colors
struct AppColors {
    static let primary = Color.blue
    static let background = Color.white
    static let navigationBar = Color(.lightGray)
    static let avatarBackground = Color(.systemGray5)
}

// MARK: - App Dimensions
struct AppDimensions {
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }
    
    struct Avatar {
        static let size: CGFloat = 36
    }
} 
