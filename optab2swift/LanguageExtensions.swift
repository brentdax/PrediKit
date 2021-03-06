//
//  LanguageExtensions.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

func findLast<C : Swift.Collection where C.GeneratorType.Element : Equatable>(domain: C, value: C.GeneratorType.Element) -> C.IndexType? {
    return reduce(realEnumerate(domain), nil) { (prevIndex: C.IndexType?, pair: (index: C.IndexType, elem: C.GeneratorType.Element)) -> C.IndexType? in
        if pair.elem == value {
            return pair.index
        }
        else {
            return prevIndex
        }
    }
}

func realEnumerate<C: Swift.Collection>(collection: C) -> SequenceOf<(C.IndexType, C.GeneratorType.Element)> {
    var i: C.IndexType = collection.startIndex
    
    return SequenceOf() { () -> GeneratorOf<(C.IndexType, C.GeneratorType.Element)> in
        return GeneratorOf() {
            if i != collection.endIndex {
                let value = (i, collection[i])
                i = i.successor()
                return value
            }
            else {
                return nil
            }
        }
    }
}
