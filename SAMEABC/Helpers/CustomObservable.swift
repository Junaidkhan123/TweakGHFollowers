//
//  CustomObservable.swift
//  SAMEABC
//
//  Created by Junaid Khan on 15/05/2025.
//

import Foundation
class CustomObservable<T> {
    
    var value: T {
        didSet {
            blocks.forEach( { $0(value) })
        }
    }
    
    private var blocks: [(T) -> Void] = []
    
    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(_ block: @escaping (T) -> Void) {
        blocks.append(block)
    }
}
