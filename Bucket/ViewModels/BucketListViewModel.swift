import Foundation
import CoreData
import Combine

class BucketListViewModel: ObservableObject {
    @Published var bucketLists: [BucketListViewData] = []
    private var cancellables = Set<AnyCancellable>()
    var context: NSManagedObjectContext?

    init() {
        // The context will be set later, in the view's `onAppear` method
    }

    func fetchBucketLists() {
        guard let context = context else { return }

        let request: NSFetchRequest<BucketList> = BucketList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BucketList.createdDate, ascending: true)]

        do {
            let results = try context.fetch(request)
            self.bucketLists = results.map { BucketListViewData(bucketList: $0) }
        } catch {
            print("Error fetching bucket lists: \(error.localizedDescription)")
        }
    }

    func addBucketList(title: String) {
        guard let context = context else { return }

        let newBucketList = BucketList(context: context)
        newBucketList.listID = UUID()
        newBucketList.title = title
        newBucketList.createdDate = Date()

        saveContext()
        fetchBucketLists()
    }

    func deleteBucketList(at offsets: IndexSet) {
        guard let context = context else { return }

        for index in offsets {
            let bucketListData = bucketLists[index]
            context.delete(bucketListData.bucketList)
        }
        saveContext()
        fetchBucketLists()
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

struct BucketListViewData: Identifiable {
    let id: NSManagedObjectID
    let title: String
    let createdDate: Date
    let bucketList: BucketList

    init(bucketList: BucketList) {
        self.id = bucketList.objectID
        self.title = bucketList.title ?? "Untitled"
        self.createdDate = bucketList.createdDate ?? Date()
        self.bucketList = bucketList
    }
}
