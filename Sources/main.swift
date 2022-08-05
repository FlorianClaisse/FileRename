import Foundation

let options = Arguments.parseOrExit()

guard FileManager.default.directoryExists(atPath: options.input) else {
    fatalError("Le dossier d'entree est introuvable ou n'existe pas.")
}

let subDirectorys = FileManager.default.subDirectories(forPath: URL(fileURLWithPath: options.input))

for subDirectory in subDirectorys {
    let subDirName = subDirectory.lastPathComponent
    let dirFiles = FileManager.default.filesURL(atPath: subDirectory, withExtension: options.type)
    
    if dirFiles.isEmpty { continue }
    
    let newLocation = URL(fileURLWithPath: options.input).appendingPathComponent(subDirName + "." + dirFiles.first!.pathExtension)
    
    try! FileManager.default.moveItem(at: dirFiles.first!, to: newLocation)
}
