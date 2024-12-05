//
//  Utilities.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 04/12/2024.
//

import Foundation
import SwiftUI

class Utilities{
    public static var shared = Utilities()
    // Helper function to determine background color based on status
    public func getBackgroundColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return Color.green.opacity(0.25) // Light green for alive
        case "dead":
            return Color.red.opacity(0.25) // Light red for dead
        case "unknown":
            return Color.blue.opacity(0.25) // Light blue for unknown
        default:
            return Color.gray.opacity(0.25) // Default background color
        }
    }
}

enum CharacterStatus: String, CaseIterable {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
