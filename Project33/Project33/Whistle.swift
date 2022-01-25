//
//  Whistle.swift
//  Project33
//
//  Created by Андрей Гавриков on 25.01.2022.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
