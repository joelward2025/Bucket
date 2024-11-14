//
//  BucketListView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import SwiftUI
import CoreData

struct BucketListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BucketList.createdDate, ascending: true)],
        animation: .default)
    private var bucketLists: FetchedResults<BucketList>

    @State private var showAddBucketListView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(bucketLists) { bucketList in
                    NavigationLink(destination: ActivityListView(bucketList: bucketList)) {
                        Text(bucketList.title ?? "Untitled List")
                    }
                }
                .onDelete(perform: deleteBucketLists)
            }
            .navigationTitle("My Bucket Lists")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddBucketListView.toggle()
                    }) {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddBucketListView) {
                AddBucketListView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deleteBucketLists(offsets: IndexSet) {
        withAnimation {
            offsets.map { bucketLists[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                print("Error deleting bucket list: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    BucketListView()
}
