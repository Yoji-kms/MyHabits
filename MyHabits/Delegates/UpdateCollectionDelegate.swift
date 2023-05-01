//
//  UpdateScreenDelegate.swift
//  MyHabits
//
//  Created by Yoji on 08.01.2023.
//

import Foundation

@objc protocol UpdateCollectionDelegate {
    @objc optional func insert()
    @objc optional func remove(index: IndexPath)
    @objc optional func update(index: IndexPath)
}
