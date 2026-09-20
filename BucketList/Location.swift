import Foundation
import MapKit

struct MapLocation: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func ==(lhs: MapLocation, rhs: MapLocation) -> Bool {
        lhs.id == rhs.id
    }
}
