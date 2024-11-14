//
//  BucketListDetailView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import SwiftUI

struct BucketListDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var bucketList: BucketList

    @State private var title: String = ""

    var body: some View {
        Form {
            Section(header: Text("List Title")) {
                TextField("Enter title", text: $title)
            }
            // Additional sections for activities can be added here
        }
        .navigationTitle("Edit Bucket List")
        .navigationBarItems(
            trailing: Button("Save") {
                updateBucketList()
            }.disabled(title.isEmpty)
        )
        .onAppear {
            title = bucketList.title ?? ""
        }
    }

    private func updateBucketList() {
        bucketList.title = title

        do {
            try viewContext.save()
        } catch {
            print("Error updating bucket list: \(error.localizedDescription)")
        }
    }
}

#Preview {
    // BucketListDetailView()
}
