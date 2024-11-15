import Foundation
import CoreData

class ActivityListViewModel: ObservableObject {
    @Published var activities: [ActivityViewData] = []
    var context: NSManagedObjectContext?
    private let bucketList: BucketList

    init(bucketList: BucketList) {
        self.bucketList = bucketList
        // Context will be set later in the view
    }

    func fetchActivities() {
        guard let context = context else { return }
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        request.predicate = NSPredicate(format: "bucketList == %@", bucketList)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Activity.name, ascending: true)]
        
        do {
            let activities = try context.fetch(request)
            self.activities = activities.map { ActivityViewData(activity: $0) }
        } catch {
            print("Failed to fetch activities: \(error.localizedDescription)")
        }
    }

    func addActivity(name: String, location: String?, plannedDate: Date?, imageData: Data?) {
        guard let context = context else { return }

        let newActivity = Activity(context: context)
        newActivity.activityID = UUID()
        newActivity.name = name
        newActivity.location = location
        newActivity.plannedDate = plannedDate
        newActivity.isCompleted = false
        newActivity.bucketList = bucketList

        if let imageData = imageData {
            let newPhoto = Photo(context: context)
            newPhoto.photoID = UUID()
            newPhoto.imageData = imageData
            newPhoto.uploadDate = Date()
            newPhoto.activity = newActivity
            newActivity.addToPhotos(newPhoto)
        }

        saveContext()
        fetchActivities()
    }

    func deleteActivity(at offsets: IndexSet) {
        guard let context = context else { return }

        for index in offsets {
            let activityData = activities[index]
            context.delete(activityData.activity)
        }
        saveContext()
        fetchActivities()
    }

    private func saveContext() {
        guard let context = context else { return }

        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}

struct ActivityViewData: Identifiable {
    let id: NSManagedObjectID
    let name: String
    let location: String?
    let plannedDate: Date?
    let isCompleted: Bool
    let imageData: Data?
    let activity: Activity

    init(activity: Activity) {
        self.id = activity.objectID
        self.name = activity.name ?? "Untitled Activity"
        self.location = activity.location
        self.plannedDate = activity.plannedDate
        self.isCompleted = activity.isCompleted
        if let photos = activity.photos as? Set<Photo>, let photo = photos.first {
            self.imageData = photo.imageData
        } else {
            self.imageData = nil
        }
        self.activity = activity
    }
}
