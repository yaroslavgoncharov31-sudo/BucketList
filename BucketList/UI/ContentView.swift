import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        MapReader { proxy in
            Map(initialPosition: viewModel.position) {
                ForEach(viewModel.locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                    Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .backgroundStyle(.white)
                            .clipShape(.circle)
                            .onLongPressGesture {
                                viewModel.selectedLocation = location
                            }
                    }
                }
            }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = MapLocation(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        viewModel.locations.append(newLocation)
                    }
                }
                .sheet(item: $viewModel.selectedLocation) { location in
                    DetailView(location: location) { newLocation in
                        if let index = viewModel.locations.firstIndex(of: location) {
                            viewModel.locations[index] = newLocation
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
