//
//  Data-Extension.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 7/3/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

//https://stackoverflow.com/questions/27327067/append-text-or-data-to-text-file-in-swift

extension Data {
    func append(to url: URL) throws {
        if let fileHandle = try? FileHandle(forWritingTo: url) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: url)
        }
    }
}
