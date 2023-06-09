import Foundation

let options = Arguments.parseOrExit()

guard FileManager.default.directoryExists(atPath: options.input) else {
    fatalError("Le dossier d'entree est introuvable ou n'existe pas.")
}

let subDirectorys = FileManager.default.subDirectories(forPath: URL(fileURLWithPath: options.input))

for subDirectory in subDirectorys {
    let subDirName = subDirectory.lastPathComponent
    var dirFiles: [URL]
    if let name = options.name {
        dirFiles = FileManager.default.filesURL(atPath: subDirectory, withExtension: options.type).filter { $0.lastPathComponent == name + "." + options.type }
    } else {
        dirFiles = FileManager.default.filesURL(atPath: subDirectory, withExtension: options.type)
    }
    
    if dirFiles.isEmpty { fatalError("Un dossier ne contient pas de fichier avec l'extension \(options.type)") }
    
    let newLocation = URL(fileURLWithPath: options.input).appendingPathComponent(subDirName + "." + dirFiles.first!.pathExtension)
    
    do {
        try FileManager.default.copyItem(at: dirFiles.first!, to: newLocation)
    } catch {
        print(error.localizedDescription)
    }
}
