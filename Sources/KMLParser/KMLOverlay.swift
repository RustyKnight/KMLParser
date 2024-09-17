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

public protocol KMLOverlay: MKOverlay {
    associatedtype Renderer: MKOverlayRenderer
    func renderer() -> Renderer
    var extendedData: [String: String]? { set get }

    var boundingMapRect: MKMapRect { get }
    var coordinate: CLLocationCoordinate2D { get }

//    func draw(snapShot: MKMapSnapshotter.Snapshot, in context: CGContext)
//
//#if canImport(UIKit)
//    func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (UIImage) throws -> Void
//    )
//#elseif canImport(AppKit)
//    func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (NSImage) throws -> Void
//    )
//#endif
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
        print(">> KMLPolygon")
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
//
//    public func draw(snapShot: MKMapSnapshotter.Snapshot, in context: CGContext) {
//
//    }
//
//#if canImport(UIKit)
//    public func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (UIImage) throws -> Void
//    ) { }
//#elseif canImport(AppKit)
//    public func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (NSImage) throws -> Void
//    ) { }
//#endif
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
//
//    private func configure(_ context: CGContext) {
//        for style in styles {
//            switch style {
//            case .line(let color, let width):
//                context.setStrokeColor(color.cgColor)
//                context.setLineWidth(width)
//            default:
//                break
//            }
//        }
//    }
//
//    public func draw(snapShot: MKMapSnapshotter.Snapshot, in context: CGContext) {
//        context.setStrokeColor(NSColor.blue.cgColor)
//        context.setLineWidth(12.0)
//        context.setLineCap(.round)
//        context.setLineJoin(.round)
//
//        let coordinates = self.coordinates
//        for (index, coordinate) in coordinates.enumerated() {
//            let point = snapShot.point(for: coordinate)
//            if index == 0 {
//                context.move(to: point)
//            } else {
//                context.addLine(to: point)
//            }
//        }
//
//        context.strokePath()
//    }
//
//#if canImport(UIKit)
//    public func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (UIImage) throws -> Void
//    ) { }
//#elseif canImport(AppKit)
//    public func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (NSImage) throws -> Void
//    ) {
//        // These details need to form part of some kind of configuration
//        context.setStrokeColor(NSColor.blue.cgColor)
//        context.setLineWidth(12.0)
//        context.setLineCap(.round)
//        context.setLineJoin(.round)
//
//        let coordinates = Array(self.coordinates)
//        let points = coordinates.converted(snapShot: snapShot)
//        let frameCount = Int(ceil(fps * duration))
//
//        let targetSize = snapShot.image.size
//
//        for frame in 0..<frameCount {
//            let progress = max(0, min(1, Double(frameCount) / Double(frame)))
//            let pointIndex = Int(Double(coordinates.count) * progress)
//
//            let subPath = Array(points[0...pointIndex]).cgPath
//            NSImage(size: targetSize) { context in
//            }
//        }
//    }
//
//    func render(_ path: CGPath, in context: CGContext) {
//        context.setStrokeColor(NSColor.blue.cgColor)
//        context.setLineWidth(12.0)
//        context.setLineCap(.round)
//        context.setLineJoin(.round)
//
//        context.addPath(path)
//
//        context.strokePath()
//    }
//#endif
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
        print(">> KMLCircle")
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
//
//    public func draw(snapShot: MKMapSnapshotter.Snapshot, in context: CGContext) {
//
//    }
//
//#if canImport(UIKit)
//    public func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (UIImage) throws -> Void
//    ) { }
//#elseif canImport(AppKit)
//    public func render(
//        snapShot: MKMapSnapshotter.Snapshot,
//        in context: CGContext,
//        duration: TimeInterval,
//        framesPerSecond fps: Double,
//        writer: (NSImage) throws -> Void
//    ) { }
//#endif
}

public extension MKMultiPoint {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](
            repeating: kCLLocationCoordinate2DInvalid,
            count: pointCount
        )

        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))

        return coords
    }
}

extension Sequence where Element == CLLocationCoordinate2D {
    func converted(snapShot: MKMapSnapshotter.Snapshot) -> [CGPoint] {
        var points = [CGPoint]()
        for coordinate in self {
            points.append(snapShot.point(for: coordinate))
        }
        return points
    }
}

extension Array where Element == CGPoint {
    var cgPath: CGPath {
        var path = CGMutablePath()
        guard isEmpty == false else {
            return path
        }
        path.move(to: first!)
        let remaining = self[1..<count]
        for point in remaining {
            path.addLine(to: point)
        }

        return path
    }
}

extension NSImage {
    convenience init(size: CGSize, actions: (CGContext) -> Void) {
        self.init(size: size)
        lockFocusFlipped(false)
        actions(NSGraphicsContext.current!.cgContext)
        unlockFocus()
    }
}
