//
//  Sorter.swift
//  Sortrr
//
//  Created by Mehdi Merkachi on 10/09/2024.
//

import Foundation
import SwiftUI

// Define a structure for custom folders
struct CustomFolder: Codable, Identifiable {
    var id: String { folderName }  // Use folderName as the id
    var folderName: String
    var extensions: [String]
}


class Sorter: ObservableObject {
    @Published var customFolders: [CustomFolder] = []
    @Published var newFileType: String = ""
    @Published var newFolder: String = ""
        
    let fileManagerHelper = FileManagerHelper()
    
    init() {
        fileManagerHelper.copyConfigFileIfNeeded()  // Ensure config file exists
        customFolders = fileManagerHelper.loadSettings()  // Load the settings
    }

    // Sorting function (sorts files in Downloads folder based on custom folder mappings)
    func sortDownloads() {
        let fileManager = FileManager.default
        guard let downloadsURL = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first else {
            print("Unable to access Downloads folder.")
            return
        }

        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: downloadsURL, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                let fileExtension = fileURL.pathExtension.lowercased()

                // Check if it's a folder (folders have no extensions)
                let isFolder = (try? fileURL.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) ?? false

                // Handle Folders
                if isFolder {
                    let folderName = fileURL.lastPathComponent

                    // Check if the folder name exists in the custom folders (from config.json)
                    if customFolders.contains(where: { $0.folderName == folderName }) {
                        // This folder is one of the custom folders, so skip moving it
                        print("\(folderName) is a custom folder, skipping...")
                        continue
                    } else {
                        // Move this folder to the "Other" directory
                        let otherFolderURL = downloadsURL.appendingPathComponent("Folders")

                        // Create the "Other" folder if it doesn't exist
                        try? fileManager.createDirectory(at: otherFolderURL, withIntermediateDirectories: true)

                        // Move the folder to the "Other" folder
                        let destinationFileURL = otherFolderURL.appendingPathComponent(fileURL.lastPathComponent)
                        try? fileManager.moveItem(at: fileURL, to: destinationFileURL)

                        print("Moved folder \(fileURL.lastPathComponent) to Other")
                    }
                } else {
                    // Handle Files

                    if let folderName = getFolderName(for: fileExtension) {
                        // Found a match in config.json, move the file
                        let destinationURL = downloadsURL.appendingPathComponent(folderName)

                        // Create the directory if it doesn't exist
                        try? fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true)

                        // Move the file to the destination folder
                        let destinationFileURL = destinationURL.appendingPathComponent(fileURL.lastPathComponent)
                        try? fileManager.moveItem(at: fileURL, to: destinationFileURL)

                        print("Moved file \(fileURL.lastPathComponent) to \(folderName)")
                    } else {
                        // Move to "Other" if no match is found for this file
                        let otherFolderURL = downloadsURL.appendingPathComponent("Other")

                        // Create the "Other" folder if it doesn't exist
                        try? fileManager.createDirectory(at: otherFolderURL, withIntermediateDirectories: true)

                        // Move the file to the "Other" folder
                        let destinationFileURL = otherFolderURL.appendingPathComponent(fileURL.lastPathComponent)
                        try? fileManager.moveItem(at: fileURL, to: destinationFileURL)

                        print("Moved file \(fileURL.lastPathComponent) to Other")
                    }
                }
            }
            print("Sorting complete")
        } catch {
            print("Error accessing Downloads folder: \(error)")
        }
    }


    // Helper function to get the folder name based on file extension
    func getFolderName(for fileExtension: String) -> String? {
        for folder in customFolders {
            if folder.extensions.contains(fileExtension.lowercased()) {
                return folder.folderName
            }
        }
        return nil
    }
}
