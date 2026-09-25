import Foundation
import MapKit
import SwiftUI

@Observable
final class DetailViewModel {
    var name: String
    var description: String
    private var originalLocation: MapLocation
    var onSave: (MapLocation) -> Void
    var loadingState = LoadingStates.loading
    var pages = [Page]()
    private let networkHelper = NetworkHelper()

    init(location: MapLocation, onSave: @escaping (MapLocation) -> Void) {
        self.originalLocation = location
        self.name = location.name
        self.description = location.description
        self.onSave = onSave
    }

    func saveLocation() {
        let updatedLocation = MapLocation(
            id: originalLocation.id,
            name: name,
            description: description,
            latitude: originalLocation.latitude,
            longitude: originalLocation.longitude
        )
        onSave(updatedLocation)
    }
    func loadNearbyPlaces(location: MapLocation) async {
        do {
            pages = try await networkHelper.fetchNearbyPlaces(location: location)
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
        
    }
}
