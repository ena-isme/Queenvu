//
//  UserEntity+CoreData.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var userID: String
    @NSManaged public var fullName: String?
    @NSManaged public var email: String?
    @NSManaged public var friends: NSSet?
}
