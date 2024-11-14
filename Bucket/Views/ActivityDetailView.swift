//
//  ActivityDetailView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var activity: Activity

    @State private var name: String = ""
    @State private var location: String = ""
    @State private var plannedDate: Date = Date()
    @State private var includeDate: Bool = false
    @State private var showImagePicker = false
    @State private var selectedImageData: Data?


    var body: some View {
        Form {
            Section(header: Text("Activity Name")) {
                TextField("Enter activity name", text: $name)
            }

            Section(header: Text("Location")) {
                TextField("Enter location", text: $location)
            }

            Section(header: Text("Planned Date")) {
                Toggle(isOn: $includeDate) {
                    Text("Include Date")
                }
                if includeDate {
                    DatePicker("Select Date", selection: $plannedDate, displayedComponents: .date)
                }
            }
            Section(header: Text("Photo")) {
                if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .onTapGesture {
                            showImagePicker = true
                        }
                } else {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Select Photo")
                        }
                    }
                }
            }

            Section {
                Toggle(isOn: $activity.isCompleted) {
                    Text("Completed")
                }
            }
        }
        .navigationTitle("Edit Activity")
        .navigationBarItems(
            trailing: Button("Save") {
                updateActivity()
            }.disabled(name.isEmpty)
        )
        .onAppear {
            name = activity.name ?? ""
            location = activity.location ?? ""
            if let date = activity.plannedDate {
                plannedDate = date
                includeDate = true
            } else {
                includeDate = false
            }

            // Load the image data from the activity's photos
            if let photos = activity.photos as? Set<Photo>, let photo = photos.first {
                selectedImageData = photo.imageData
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImageData: $selectedImageData)
        }

    }

    private func updateActivity() {
        activity.name = name
        activity.location = location.isEmpty ? nil : location
        if includeDate {
            activity.plannedDate = plannedDate
        } else {
            activity.plannedDate = nil
        }

        // Update or add photo
        if let imageData = selectedImageData {
            if let photos = activity.photos as? Set<Photo>, let photo = photos.first {
                // Update existing photo
                photo.imageData = imageData
                photo.uploadDate = Date()
            } else {
                // Add new photo
                let newPhoto = Photo(context: viewContext)
                newPhoto.photoID = UUID()
                newPhoto.imageData = imageData
                newPhoto.uploadDate = Date()
                newPhoto.activity = activity
            }
        } else {
            // Remove photo if image data is nil
            if let photos = activity.photos as? Set<Photo> {
                for photo in photos {
                    viewContext.delete(photo)
                }
            }
        }

        do {
            try viewContext.save()
        } catch {
            print("Error updating activity: \(error.localizedDescription)")
        }
    }

}
