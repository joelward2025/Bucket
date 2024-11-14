//
//  Photo.swift
//  Bucket
//
//  Created by Joel Ward on 11/12/24.
//

import Foundation
import CoreData

public class Photo: NSManagedObject {

}

extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var uploadDate: Date?
    @NSManaged public var activity: Activity?

}

extension Photo : Identifiable {

}
