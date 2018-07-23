//
//  RealmManager.swift
//  SampleAlamofireMapper
//
//  Created by Jafar Khan on 7/19/18.
//  Copyright © 2018 Thahir. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmManager {
    
    // singleton
    static let shared = RealmManager()
    private init() {}
    
    private let realm = try? Realm()
    
    func get<Object: BaseRealmMapper>(type: Object.Type) -> [Object] {
        var objects = [Object]()
        guard let realmObjects = realm?.objects(type) else {
            return objects
        }
        objects.append(contentsOf: realmObjects)
        return objects
    }
    
    func deleteObject(object:Object) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        }
        catch let error as NSError {
            //TODO: Handle error
            print(error)
        }
    }
    
    func deleteObjects(objects:[Object]) {
        do {
            try realm?.write {
                realm?.delete(objects)
            }
        }
        catch let error as NSError {
            //TODO: Handle error
            print(error)
        }
    }
    
    func addObject(object:Object,update:Bool = true) {
        do {
            try realm?.write {
                realm?.add(object, update: update)
            }
        } catch let error as NSError {
            //TODO: Handle error
            print(error)
        }
    }
    
    func addObjects(objects:[Object],update:Bool = true) {
        do {
            try realm?.write {
                realm?.add(objects, update: update)
            }
        } catch let error as NSError {
            //TODO: Handle error
            print(error)
        }
    }
    
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        }
        catch let error as NSError {
            //TODO: Handle error
            print(error)
        }
    }
}
