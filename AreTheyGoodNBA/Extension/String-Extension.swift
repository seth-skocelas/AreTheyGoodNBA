//
//  String-Extension.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 7/3/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

//https://stackoverflow.com/questions/27327067/append-text-or-data-to-text-file-in-swift

extension String {
    func appendLine(to url: URL) throws {
        try self.appending("\n").append(to: url)
    }
    func append(to url: URL) throws {
        var data = self.data(using: String.Encoding.utf8)
        try data?.append(to: url)
    }
}
