//
//  Array+Only.swift
//  Memorize
//
//  Created by datalab on 2020/7/2.
//  Copyright © 2020 datalab. All rights reserved.
//

import Foundation

extension Array{
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
