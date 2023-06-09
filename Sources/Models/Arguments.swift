//
//  File.swift
//  
//
//  Created by Florian Claisse on 05/08/2022.
//

import ArgumentParser


struct Arguments: ParsableCommand {
    @Option(help: "Chemin vers le dossier racine.")
    var input: String
    
    @Option(help: "Extension des fichiers à trouver et à renommer")
    var type: String
    
    @Option(help: "The name of the file to find.")
    var name: String?
}
