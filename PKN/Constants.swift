import Foundation
import SwiftUI

// MARK: - App Strings
public struct AppStrings {
    
    // MARK: - Icons
    public struct Icons {
        public static let checkmark = "checkmark"
    }
    
    // MARK: - Titles
    public struct Titles {
        public static let selectMember = "Select Member"
    }
}

// MARK: - App Colors
public struct AppColors {
    public static let primary = Color.blue
    public static let background = Color.white
    public static let navigationBar = Color(.lightGray)
    public static let avatarBackground = Color(.systemGray5)
}

// MARK: - App Dimensions
public struct AppDimensions {
    public struct Spacing {
        public static let small: CGFloat = 8
        public static let medium: CGFloat = 12
        public static let large: CGFloat = 16
    }
    
    public struct Avatar {
        public static let size: CGFloat = 36
    }
} 
