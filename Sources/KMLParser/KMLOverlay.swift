//
//  File.swift
//  KMLParser
//
//  Created by Alexander van der Werff on 18/03/2017.
//  Copyright © 2017 AvdWerff. All rights reserved.
//

import Foundation
import MapKit
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public protocol KMLOverlay {
    associatedtype Renderer: MKOverlayRenderer
    func renderer() -> Renderer
    var extendedData: [String: String]? { set get }

    var boundingMapRect: MKMapRect { get }
    var coordinate: CLLocationCoordinate2D { get }
}

/// # KMLPolygon
open class KMLPolygon: MKPolygon, KMLOverlay, KMLStyleable {

    public var extendedData: [String: String]?

    var styles: [KMLStyle] = []

    var outline = true

    var fill = true

    var lineWidth: CGFloat = 0

#if canImport(UIKit)
    var strokeColor: UIColor = UIColor.clear

    var fillColor: UIColor = UIColor.clear
#elseif canImport(AppKit)
    var strokeColor = NSColor.clear

    var fillColor = NSColor.clear
#endif

    open func renderer() -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(polygon: self)
        for style in styles {
            switch style {
            case .line(let color, let width):
                self.lineWidth = width
                self.strokeColor = color
            case .poly(let color, let fill, let outline):
                self.outline = outline
                self.fill = fill
                self.fillColor = color
            default:
                break
            }
        }
        if fill {
            renderer.fillColor = fillColor
        }
        if outline {
            renderer.lineWidth = lineWidth
            renderer.strokeColor = strokeColor
        }
        return renderer
    }

}

open class KMLLineString: MKPolyline, KMLOverlay, KMLStyleable {

    public var extendedData: [String: String]?

    var styles: [KMLStyle] = []

    var lineWidth: CGFloat = 0
#if canImport(UIKit)
    var strokeColor: UIColor = UIColor.clear
#elseif canImport(AppKit)
    var strokeColor = NSColor.clear
#endif

    open func renderer() -> MKPolylineRenderer {
        let renderer = MKPolylineRenderer(polyline: self)
        for style in styles {
            switch style {
            case .line(let color, let width):
                self.lineWidth = width
                self.strokeColor = color
            default:
                break
            }
        }
        renderer.lineWidth = lineWidth
        renderer.strokeColor = strokeColor
        return renderer
    }
}

open class KMLCircle: MKCircle, KMLOverlay, KMLStyleable {

    public var extendedData: [String: String]?

    var styles: [KMLStyle] = []

    var lineWidth: CGFloat = 0

#if canImport(UIKit)
    var strokeColor: UIColor = UIColor.clear

    var fillColor: UIColor = UIColor.clear
#elseif canImport(AppKit)
    var strokeColor = NSColor.clear

    var fillColor = NSColor.clear
#endif

    var outline = true

    var fill = true

    open func renderer() -> MKCircleRenderer {
        let renderer = MKCircleRenderer(circle: self)
        for style in styles {
            switch style {
            case .line(let color, let width):
                self.lineWidth = width
                self.strokeColor = color
            case .circle(let color, let fill, let outline):
                self.outline = outline
                self.fill = fill
                self.fillColor = color
            default:
                break
            }
        }
        if fill {
            renderer.fillColor = fillColor
        }
        if outline {
            renderer.lineWidth = lineWidth
            renderer.strokeColor = strokeColor
        }
        return renderer
    }
}
