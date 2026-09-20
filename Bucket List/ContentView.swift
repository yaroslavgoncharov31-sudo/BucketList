import SwiftUI
import MapKit

struct ContentView: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
        var body: some View {
            Map (position: $position)
                .mapStyle(.hybrid(elevation: .realistic))
        }
}

#Preview {
    ContentView()
}
