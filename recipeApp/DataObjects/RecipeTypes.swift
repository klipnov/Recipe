//
//  RecipeTypes.swift
//  recipeApp
//
//  Created by Shah Qays on 21/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation

class RecipeTypes: NSObject, XMLParserDelegate {
    
    var names = [String]()
    
    var element = String()
    var name = String()
    
    override init() {
        super.init()
        loadDataFromXML()
    }
    
    private func loadDataFromXML() {
        
        guard let data = loadFile() else {
            return
        }
        
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    private func loadFile() -> Data? {
        let fileLoader = FileLoader()

        do {
            return try fileLoader.load(filename: "recipetypes.xml")
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        element = elementName
        
        if elementName == "name" {
            name = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "name" {
            names.append(name)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element == "name" {
            name += string
        }
    }
}
