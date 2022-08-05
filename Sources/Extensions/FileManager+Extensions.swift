//
//  File.swift
//  
//
//  Created by Florian Claisse on 05/08/2022.
//

import Foundation


extension FileManager {
    
    func subDirectories(forPath path: URL) -> [URL] {
        guard path.hasDirectoryPath else { return [] }
        let all = try! self.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
        return all.filter(\.hasDirectoryPath)
    }
    
    func filesURL(atPath path: URL, withExtension extension: String) -> [URL] {
        let directoryContent = try! self.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        let files = directoryContent.filter { $0.pathExtension == `extension` }
        
        return files
        
    }
    
    @discardableResult
    func directoryExists(atPath path: String, create: Bool = false) -> Bool {
        self.directoryExists(atPath: URL(fileURLWithPath: path), create: create)
    }
    
    @discardableResult
    func directoryExists(atPath path: URL, create: Bool = false) -> Bool {
        var isDir: ObjCBool = false
        let exists = self.fileExists(atPath: path.path, isDirectory: &isDir)
        
        if !exists {
            if create { try! self.createDirectory(at: path, withIntermediateDirectories: true) }
            return false
        }
        
        return isDir.boolValue
    }
    
}
