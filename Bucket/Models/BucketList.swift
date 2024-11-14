//
//  BucketList.swift
//  Bucket
//
//  Created by Joel Ward on 11/12/24.
//

import Foundation
import CoreData

public class BucketList: NSManagedObject {

}

extension BucketList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BucketList> {
        return NSFetchRequest<BucketList>(entityName: "BucketList")
    }

    @NSManaged public var createdDate: Date?
    @NSManaged public var listID: UUID?
    @NSManaged public var title: String?
    @NSManaged public var activities: NSSet?
    @NSManaged public var owner: User?

}

// MARK: Generated accessors for activities
extension BucketList {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension BucketList : Identifiable {

}
