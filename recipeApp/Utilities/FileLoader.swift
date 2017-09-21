//
//  XMLParser.swift
//  recipeApp
//
//  Created by Shah Qays on 21/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation

enum FileLoaderError: Error {
    case fileNameError
    case fileNotFound
}

class FileLoader {
    
    init() {}
    
    func load(filename: String) throws -> Data {
        
        var split = [String]()
        
        //splits the filename
        do {
            split = try splitFileName(filename: filename)
        } catch FileLoaderError.fileNameError {
            throw FileLoaderError.fileNameError
        }
        
        //finds the file and load 
        guard let xmlPath = Bundle.main.path(forResource: split[0], ofType: split[1]),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath)) else {
                throw FileLoaderError.fileNotFound
        }

        return data
    }
    
    private func splitFileName(filename: String) throws -> [String] {
        
        let splitFileName = filename.components(separatedBy: ".")
        
        guard splitFileName.count > 1 else {
            throw FileLoaderError.fileNameError
        }
        
        return splitFileName
    }
    
}
