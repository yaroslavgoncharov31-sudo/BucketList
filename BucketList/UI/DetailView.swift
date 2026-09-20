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
            }
            .navigationTitle("Place detail")
            .toolbar {
                Button("Save") {
                    detailViewModel.save()
                    dismiss()
                }
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
