//
//  MemberEntity+CoreData.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import Foundation
import CoreData

@objc(MemberEntity)
public class MemberEntity: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberEntity> {
        return NSFetchRequest<MemberEntity>(entityName: "MemberEntity")
    }

    @NSManaged public var heart: Int
    @NSManaged public var memberEmail: String
    @NSManaged public var user: UserEntity?
}
