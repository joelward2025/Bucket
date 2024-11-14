//
//  ActivityDetailView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: ActivityViewModel
    @State private var showImagePicker = false

    init(activity: Activity) {
        _viewModel = StateObject(wrappedValue: ActivityViewModel(activity: activity))
    }

    var body: some View {
        Form {
            Section(header: Text("Activity Name")) {
                TextField("Enter activity name", text: $viewModel.name)
            }
            Section(header: Text("Location")) {
                TextField("Enter location", text: $viewModel.location)
            }
            Section(header: Text("Planned Date")) {
                Toggle(isOn: Binding(
                    get: { viewModel.plannedDate != nil },
                    set: { includeDate in
                        if includeDate {
                            viewModel.plannedDate = Date()
                        } else {
                            viewModel.plannedDate = nil
                        }
                    }
                )) {
                    Text("Include Date")
                }
                if viewModel.plannedDate != nil {
                    DatePicker("Select Date", selection: Binding(
                        get: { viewModel.plannedDate ?? Date() },
                        set: { newDate in viewModel.plannedDate = newDate }
                    ), displayedComponents: .date)
                }
            }
            Section(header: Text("Photo")) {
                if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
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
            Section {
                Toggle(isOn: $viewModel.isCompleted) {
                    Text("Completed")
                }
            }
        }
        .navigationTitle("Edit Activity")
        .navigationBarItems(
            trailing: Button("Save") {
                viewModel.updateActivity()
                presentationMode.wrappedValue.dismiss()
            }.disabled(viewModel.name.isEmpty)
        )
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImageData: $viewModel.imageData)
        }
        .onAppear {
            if viewModel.context == nil {
                viewModel.context = viewContext
            }
        }
    }
}
