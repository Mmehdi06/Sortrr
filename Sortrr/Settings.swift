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
                print("File extension: \(fileExtension)")

                // Find the corresponding folder for this file extension
                if let folderName = getFolderName(for: fileExtension) {
                    print("Found folder: \(folderName)")
                    let destinationURL = downloadsURL.appendingPathComponent(folderName)

                    // Create directory if it doesn't exist
                    try? fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true)

                    // Move the file to the destination folder
                    let destinationFileURL = destinationURL.appendingPathComponent(fileURL.lastPathComponent)
                    try? fileManager.moveItem(at: fileURL, to: destinationFileURL)

                    print("Moved \(fileURL.lastPathComponent) to \(folderName)")
                } else {
//                    print("No folder found for extension: \(fileExtension)")
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
