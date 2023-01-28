//
//  ThreadSafe.swift
//  Presentation
//
//  Created by Jeroen Bakker on 28/01/2023.
//

import Foundation

@propertyWrapper
public struct ThreadSafe<Value> {
    
    private let queue = DispatchQueue(label: "com.flickrfinder.\(UUID().uuidString)")
    private var value: Value
    
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    public var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
}
