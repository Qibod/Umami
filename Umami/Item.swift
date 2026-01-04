//
//  Item.swift
//  Umami
//
//  Created by Vijay R on 1/4/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
