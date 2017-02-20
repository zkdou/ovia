//
//  Mock.swift
//  Ovia
//
//  Created by Zongkun Dou on 2/18/17.
//  Copyright © 2017 Zongkun Dou. All rights reserved.
//

import Foundation
@testable import Ovia

class Mock: ViewModelDelegate {

    var q1Result: String = ""
    var q2Result: String = ""

    func didFinishCalculateQ1Answer(result: String) {
        q1Result = result
    }

    func didFinishCalculateQ2Answer(result: String) {
        q2Result = result
    }
}
