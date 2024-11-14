import SwiftUI

@main
struct YourApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
