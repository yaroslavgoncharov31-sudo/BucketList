import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        Group {
            if viewModel.isUnlocked {
                NavigationStack {
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
                        .mapStyle(viewModel.getMapStyle())
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                let newLocation = MapLocation(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                                viewModel.locations.append(newLocation)
                                viewModel.save()
                            }
                        }
                        .sheet(item: $viewModel.selectedLocation) { location in
                            DetailView(location: location) { newLocation in
                                if let index = viewModel.locations.firstIndex(of: location) {
                                    viewModel.locations[index] = newLocation
                                    viewModel.save()
                                }
                            }
                        }
                        .toolbar {
                            Button("Change layout", systemImage: "map") {
                                viewModel.cycleMapStyle()
                            }
                        }
                    }
                }
            } else {
                Button("Unlock places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Authentication failed", isPresented: Binding(
            get: { viewModel.authError != nil },
            set: { if !$0 { viewModel.authError = nil } }
        )) {
            Button("OK") { }
        } message: {
            Text(viewModel.authError ?? "")
        }
    }
}

#Preview {
    ContentView()
}
