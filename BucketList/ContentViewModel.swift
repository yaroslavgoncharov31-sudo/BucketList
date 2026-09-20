import MapKit
import Foundation
import SwiftUI

@Observable
class ContentViewModel {
    let position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )
    )
    var locations = [MapLocation]()
    var selectedLocation: MapLocation?

    #if DEBUG
    static let example = MapLocation(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000lightbulbs.", latitude: 51.501, longitude: -0.141)
    #endif
}
