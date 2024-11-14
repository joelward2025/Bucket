import SwiftUI

@main
struct BucketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
