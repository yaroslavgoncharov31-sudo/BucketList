import Foundation
import MapKit
import SwiftUI

@Observable
class DetailViewModel {
    var id = UUID()
    var name: String
    var description: String
    private var originalLocation: MapLocation
    var onSave: (MapLocation) -> Void

    init(location: MapLocation, onSave: @escaping (MapLocation) -> Void) {
        self.originalLocation = location
        self.name = location.name
        self.description = location.description
        self.onSave = onSave
    }

    func save() {
        let updatedLocation = MapLocation(
            id: id,
            name: name,
            description: description,
            latitude: originalLocation.latitude,
            longitude: originalLocation.longitude
        )
        onSave(updatedLocation)
    }
}
