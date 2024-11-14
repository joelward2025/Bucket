//
//  User.swift
//  Bucket
//
//  Created by Joel Ward on 11/12/24.
//

import Foundation
import CoreData

public class User: NSManagedObject {

}


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userID: UUID?
    @NSManaged public var username: String?
    @NSManaged public var profilePicture: Data?
    @NSManaged public var email: String?
    @NSManaged public var bucketLists: BucketList?
    @NSManaged public var friends: User?
    @NSManaged public var activitiesParticipated: Activity?

}

extension User : Identifiable {

}
