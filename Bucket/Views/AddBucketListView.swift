//
//  AddBucketListView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import SwiftUI

struct AddBucketListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Title")) {
                    TextField("Enter title", text: $title)
                }
            }
            .navigationTitle("New Bucket List")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    addBucketList()
                    presentationMode.wrappedValue.dismiss()
                }.disabled(title.isEmpty)
            )
        }
    }

    private func addBucketList() {
        print("Attempting to save new bucket list with title: \(title)")

        let newBucketList = BucketList(context: viewContext)
        newBucketList.listID = UUID()
        newBucketList.title = title
        newBucketList.createdDate = Date()

        do {
            try viewContext.save()
            print("Bucket list saved successfully.")
        } catch {
            print("Error saving new bucket list: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AddBucketListView()
}
