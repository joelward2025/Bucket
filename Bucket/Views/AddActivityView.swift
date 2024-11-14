//
//  AddActivityView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ActivityListViewModel

    @State private var name: String = ""
    @State private var location: String = ""
    @State private var plannedDate: Date = Date()
    @State private var includeDate: Bool = false
    @State private var selectedImageData: Data?
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
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
                            .onTapGesture { showImagePicker = true }
                    } else {
                        Button(action: { showImagePicker = true }) {
                            HStack {
                                Image(systemName: "photo")
                                Text("Select Photo")
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Activity")
            .navigationBarItems(
                leading: Button("Cancel") { presentationMode.wrappedValue.dismiss() },
                trailing: Button("Save") {
                    let date = includeDate ? plannedDate : nil
                    viewModel.addActivity(
                        name: name,
                        location: location.isEmpty ? nil : location,
                        plannedDate: date,
                        imageData: selectedImageData
                    )
                    presentationMode.wrappedValue.dismiss()
                }.disabled(name.isEmpty)
            )
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImageData: $selectedImageData)
            }
        }
    }
}
