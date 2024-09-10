//
//  SettingsView.swift
//  Sortrr
//
//  Created by Mehdi Merkachi on 09/09/2024.
//

import SwiftUI

struct SettingsView: View {
    // We observe the Settings class for any updates to the mappings
    @ObservedObject var settings = Settings()
    
    @State private var fileType: String = ""
    @State private var folder: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("File Type Mappings")
                .font(.largeTitle)
                .padding(.bottom, 10)
            
            // Display the existing mappings in a list
            List {
                ForEach(settings.fileTypeMappings.keys.sorted(), id: \.self) { key in
                    HStack {
                        Text(key.uppercased())
                        Spacer()
                        Text(settings.fileTypeMappings[key] ?? "")
                    }
                }
                .onDelete(perform: deleteMapping)
            }
            
            Divider()
                .padding(.vertical)

            // Input fields for adding new mappings
            HStack {
                VStack(alignment: .leading) {
                    Text("File Extension (e.g., mp3)").font(.headline)
                    TextField("Enter file extension", text: $fileType)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                VStack(alignment: .leading) {
                    Text("Folder Name").font(.headline)
                    TextField("Enter folder name", text: $folder)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button(action: addMapping) {
                    Text("Add")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .disabled(fileType.isEmpty || folder.isEmpty)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            settings.loadSettings()  // Load settings when the view appears
        }
    }
    
    // Add a new mapping
    func addMapping() {
        settings.addMapping(for: fileType, folder: folder)
        fileType = ""
        folder = ""
    }
    
    // Delete an existing mapping
    func deleteMapping(at offsets: IndexSet) {
        for index in offsets {
            let key = settings.fileTypeMappings.keys.sorted()[index]
            settings.removeMapping(for: key)
        }
    }
}
