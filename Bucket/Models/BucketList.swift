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

    @NSManaged public var listID: UUID?
    @NSManaged public var title: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var owner: User?
    @NSManaged public var activities: Activity?

}

extension BucketList : Identifiable {

}
