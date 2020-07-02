//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by datalab on 2020/7/2.
//  Copyright © 2020 datalab. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {
        for index in 0 ..< self.count{
            if self[index].id == matching.id{
                return index
            }
        }
        // TODO: bogus
        return nil
    }
}
