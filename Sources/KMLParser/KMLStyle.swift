//
//  KMLStyle.swift
//  KMLParser
//
//  Created by Alexander van der Werff on 18/03/2017.
//  Copyright © 2017 AvdWerff. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

protocol KMLStyleable {
    var styles: [KMLStyle] { get set }
}

extension KMLStyleable {
    mutating func add(styles: [KMLStyle]) -> KMLStyleable {
        self.styles.append(contentsOf: styles)
        return self
    }
}

enum KMLStyle {
#if canImport(UIKit)
    case
    line(color: UIColor, width: CGFloat),
    poly(color: UIColor, fill: Bool, outline: Bool),
    circle(color: UIColor, fill: Bool, outline: Bool),
    balloon(bgColor: UIColor, textColor: UIColor),
    icon(urlString: String)
#elseif canImport(AppKit)
    case
    line(color: NSColor, width: CGFloat),
    poly(color: NSColor, fill: Bool, outline: Bool),
    circle(color: NSColor, fill: Bool, outline: Bool),
    balloon(bgColor: NSColor, textColor: NSColor),
    icon(urlString: String)
#endif
}
