//
//  Activity.swift
//  Bucket
//
//  Created by Joel Ward on 11/12/24.
//

import Foundation
import CoreData

public class Activity: NSManagedObject {

}

extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var activityID: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var plannedDate: Date?
    @NSManaged public var bucketList: BucketList?
    @NSManaged public var participants: User?
    @NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for photos
extension Activity {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

extension Activity : Identifiable {

}
