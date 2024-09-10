//
//  FileManager.swift
//  Sortrr
//
//  Created by Mehdi Merkachi on 10/09/2024.
//

import Foundation

class FileManagerHelper {
    
    let configFileName = "config.json"
    
    func loadSettings() -> [CustomFolder] {
            var loadedFolders: [CustomFolder] = []
            
            // Access the config.json directly from the bundle
            if let bundleURL = Bundle.main.url(forResource: "config", withExtension: "json") {
                if let data = try? Data(contentsOf: bundleURL) {
                    do {
                        // Decode the JSON data into an array of CustomFolder
                        loadedFolders = try JSONDecoder().decode([CustomFolder].self, from: data)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            
            return loadedFolders
        }

    
    func copyConfigFileIfNeeded() {
        let fileManager = FileManager.default

        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let configFileURL = documentDirectory.appendingPathComponent(configFileName)
            
            // Check if config.json already exists in the documents directory
            if !fileManager.fileExists(atPath: configFileURL.path) {
                if let bundleURL = Bundle.main.url(forResource: "config", withExtension: "json") {
                    do {
                        // Copy the file from the bundle to the documents directory
                        try fileManager.copyItem(at: bundleURL, to: configFileURL)
                        print("Config file copied to \(configFileURL.path)")
                    } catch {
                        print("Error copying config file: \(error)")
                    }
                }
            }
        }
    }
}
