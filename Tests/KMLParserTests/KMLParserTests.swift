import Testing
import XCTest
import Foundation
@testable import KMLParser

struct Support {
    @MainActor
    static var mockedUrl: URL = {
        Bundle.module.url(forResource: "Mocked", withExtension: "kml")!
    }()

    @MainActor
    static func mockedData() throws -> Data {
        return try Data(contentsOf: mockedUrl)
    }
}

final class KMLParserTests: XCTestCase {

    func testBasicParsing() async throws {
        let waitFor = expectation(description: "Waiting for stuff")

        let data = try await Support.mockedData()
        let options = KMLOptions(pointToCircleRadius: 10000)
        KMLParser.parse(with: data, options: options) { (result) in
            switch result {
            case .failure(let reason):
                print(">> reason = \(reason)")
                XCTFail("\(reason)")
                break
            case .success(let annotations, let overlays):
                break
            }
            waitFor.fulfill()
        }

        await fulfillment(of: [waitFor])
    }

    func testAsyncParsing() async throws {
        let data = try await Support.mockedData()
        let options = KMLOptions(pointToCircleRadius: 10000)

        let kmlData = try await KMLParser.parse(with: data, options: options)
        print(kmlData)
    }
}
