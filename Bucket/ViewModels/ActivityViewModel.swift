import Foundation
import CoreData

class ActivityViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var plannedDate: Date?
    @Published var isCompleted: Bool = false
    @Published var imageData: Data?

    var context: NSManagedObjectContext?
    private let activity: Activity

    init(activity: Activity) {
        self.activity = activity
        // The context will be set later

        // Initialize properties from the activity
        self.name = activity.name ?? ""
        self.location = activity.location ?? ""
        self.plannedDate = activity.plannedDate
        self.isCompleted = activity.isCompleted
        if let photos = activity.photos as? Set<Photo>, let photo = photos.first {
            self.imageData = photo.imageData
        }
    }

    func updateActivity() {
        guard let context = context else { return }

        activity.name = name
        activity.location = location.isEmpty ? nil : location
        activity.plannedDate = plannedDate
        activity.isCompleted = isCompleted

        if let imageData = imageData {
            if let photos = activity.photos as? Set<Photo>, let photo = photos.first {
                // Update existing photo
                photo.imageData = imageData
                photo.uploadDate = Date()
            } else {
                // Add new photo
                let newPhoto = Photo(context: context)
                newPhoto.photoID = UUID()
                newPhoto.imageData = imageData
                newPhoto.uploadDate = Date()
                newPhoto.activity = activity
                activity.addToPhotos(newPhoto)
            }
        } else {
            // Remove existing photos if imageData is nil
            if let photos = activity.photos as? Set<Photo> {
                for photo in photos {
                    context.delete(photo)
                }
            }
        }

        saveContext()
    }

    private func saveContext() {
        guard let context = context else { return }

        do {
            try context.save()
        } catch {
            print("Error saving activity: \(error.localizedDescription)")
        }
    }
}
