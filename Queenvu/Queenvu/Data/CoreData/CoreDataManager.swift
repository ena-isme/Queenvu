//
//  CoreDataManager.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Queenvu")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("❌ CoreData 로드 실패: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: - UserEntity
    
    // ✅ 사용자 ID 저장
    func saveUser(userData: UserEntity) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingUser = results.first {
                existingUser.userID = userData.userID
                existingUser.fullName = userData.fullName
                existingUser.email = userData.email
            } else {
                context.insert(userData)
            }
            try context.save()
        } catch {
            print("❌ CoreData 저장 실패: \(error)")
        }
    }
    
    // ✅ 저장된 사용자 리스트 가져오기
    func fetchUserList() -> [UserEntity] {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("❌ CoreData 조회 실패: \(error)")
            return []
        }
    }
    
    // ✅ 로그아웃 (CoreData에서 삭제)
    func deleteUser() {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
        } catch {
            print("❌ CoreData 삭제 실패: \(error)")
        }
    }
    
    //MARK: - MemberEntity
    
    func saveOrUpdateMember(email: String) {
        let fetchRequest: NSFetchRequest<MemberEntity> = MemberEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "memberEmail == %@", email)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                let newMember = MemberEntity(context: context)
                newMember.memberEmail = email
                
                //0은 선택X
                newMember.heart = 0
                try context.save()
                print("✅ CoreData: \(email) 친구 등록 완료")
            } else {
                print("⚠️ 이미 등록된 친구입니다: \(email)")
            }
        } catch {
            print("❌ CoreData 친구 저장 실패: \(error)")
        }
    }
    
    func updateHeart(email: String, heartNum: Int) {
        let fetchRequest: NSFetchRequest<MemberEntity> = MemberEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "memberEmail == %@", email)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingMember = results.first {
                existingMember.heart = heartNum
                try context.save()
                print("✅ \(email) 하트 업데이트 완료 (현재 하트 번호: \(existingMember.heart))")
            } else {
                print("⚠️ 해당 이메일을 가진 친구가 없습니다.")
            }
        } catch {
            print("❌ CoreData 하트 저장 실패: \(error)")
        }
    }

    func fetchMember(email: String) -> MemberEntity? {
        let fetchRequest: NSFetchRequest<MemberEntity> = MemberEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "memberEmail == %@", email)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("❌ CoreData 친구 조회 실패: \(error)")
            return nil
        }
    }
    
    func fetchAllMembers() -> [MemberEntity] {
        let fetchRequest: NSFetchRequest<MemberEntity> = MemberEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("❌ CoreData 친구 목록 조회 실패: \(error)")
            return []
        }
    }
}
