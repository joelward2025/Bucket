//
//  BucketListView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//

import SwiftUI

struct BucketListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = BucketListViewModel()

    @State private var showAddBucketListView = false
    @State private var newBucketListTitle = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bucketLists) { bucketListData in
                    NavigationLink(destination: ActivityListView(bucketList: bucketListData.bucketList)) {
                        Text(bucketListData.title)
                    }
                }
                .onDelete(perform: viewModel.deleteBucketList)
            }
            .navigationTitle("My Bucket Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddBucketListView = true }) {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddBucketListView) {
                NavigationView {
                    Form {
                        Section(header: Text("List Title")) {
                            TextField("Enter title", text: $newBucketListTitle)
                        }
                    }
                    .navigationTitle("New Bucket List")
                    .navigationBarItems(
                        leading: Button("Cancel") { showAddBucketListView = false },
                        trailing: Button("Save") {
                            viewModel.addBucketList(title: newBucketListTitle)
                            newBucketListTitle = ""
                            showAddBucketListView = false
                        }.disabled(newBucketListTitle.isEmpty)
                    )
                }
            }
        }
        .onAppear {
            if viewModel.context == nil {
                viewModel.context = viewContext
                viewModel.fetchBucketLists()
            }
        }
    }
}


#Preview {
    BucketListView()
}
