import SwiftUI
import MapKit

struct DetailView: View {
    @State private var detailViewModel: DetailViewModel
    @Environment(\.dismiss) var dismiss
    var location: MapLocation

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $detailViewModel.name)
                    TextField("Description", text: $detailViewModel.description)
                }
                Section("Also nearby...") {
                    switch detailViewModel.loadingState {
                    case .loading:
                        HStack {
                            ProgressView()
                            Text("Loading...")
                        }

                    case .loaded:
                        ForEach(detailViewModel.pages, id: \.pageid) { page in
                            HStack {
                                Text("**\(page.title)**: \(page.description)")
                            }
                        }

                    case .failed:
                        Text("Failed to load nearby places")
                    }
                }
            }
            .navigationTitle("Place detail")
            .toolbar {
                Button("Save") {
                    detailViewModel.saveLocation()
                    dismiss()
                }
            }
            .task {
                await detailViewModel.loadNearbyPlaces(location: location)
            }
        }
    }
    init(location: MapLocation, onSave: @escaping (MapLocation) -> Void) {
        self.location = location
        _detailViewModel = State(initialValue: DetailViewModel(location: location, onSave: onSave))
    }
}

#Preview {
    DetailView(location: ContentViewModel.example, onSave: { _ in })
}
