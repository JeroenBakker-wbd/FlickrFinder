//
//  SyncSafe.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

@discardableResult
func syncSafe<T>(_ work: () -> T) -> T {
    if Thread.isMainThread {
        return work()
    } else {
        return DispatchQueue.main.sync { work() }
    }
}
