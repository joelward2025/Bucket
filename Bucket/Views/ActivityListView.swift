//
//  ActivityListView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//

import SwiftUI

struct ActivityListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ActivityListViewModel
    private let bucketList: BucketList

    @State private var showAddActivityView = false

    init(bucketList: BucketList) {
        self.bucketList = bucketList
        _viewModel = StateObject(wrappedValue: ActivityListViewModel(bucketList: bucketList))
    }

    var body: some View {
        List {
            ForEach(viewModel.activities) { activityData in
                NavigationLink(destination: ActivityDetailView(activity: activityData.activity)) {
                    HStack {
                        if let imageData = activityData.imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(5)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading) {
                            Text(activityData.name)
                                .font(.headline)
                            if let date = activityData.plannedDate {
                                Text("Planned Date: \(date, formatter: dateFormatter)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .onDelete(perform: viewModel.deleteActivity)
        }
        .navigationTitle("Activities")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showAddActivityView = true }) {
                    Label("Add Activity", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddActivityView) {
            AddActivityView(viewModel: viewModel)
                .environment(\.managedObjectContext, viewContext)
        }
        .onAppear {
            if viewModel.context == nil {
                viewModel.context = viewContext
                viewModel.fetchActivities()
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
