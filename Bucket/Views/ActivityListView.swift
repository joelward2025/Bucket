//
//  ActivityListView.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import SwiftUI
import CoreData

struct ActivityListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var bucketList: BucketList

    // Fetch activities related to the selected bucket list
    @FetchRequest private var activities: FetchedResults<Activity>

    // State variable to control the presentation of the Add Activity view
    @State private var showAddActivityView = false

    init(bucketList: BucketList) {
        self.bucketList = bucketList

        // Initialize the FetchRequest with a predicate to fetch activities for the selected bucket list
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.plannedDate, ascending: true)],
            predicate: NSPredicate(format: "bucketList == %@", bucketList),
            animation: .default
        )
    }

    var body: some View {
        List {
            ForEach(activities) { activity in
                NavigationLink(destination: ActivityDetailView(activity: activity)) {
                    HStack {
                        if let photos = activity.photos as? Set<Photo>, let photo = photos.first, let imageData = photo.imageData, let uiImage = UIImage(data: imageData) {
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
                            Text(activity.name ?? "Untitled Activity")
                                .font(.headline)
                                .onAppear {
                                    print("Activity ID: \(activity.activityID?.uuidString ?? "No ID"), Name: \(activity.name ?? "No Name")")
                                }
                            if let date = activity.plannedDate {
                                Text("Planned Date: \(date, formatter: dateFormatter)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }

            }
            .onDelete(perform: deleteActivities)
        }
        .navigationTitle(bucketList.title ?? "Bucket List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAddActivityView.toggle()
                }) {
                    Label("Add Activity", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showAddActivityView) {
            AddActivityView(bucketList: bucketList)
                .environment(\.managedObjectContext, viewContext)
        }
    }

    // MARK: - Functions

    private func deleteActivities(offsets: IndexSet) {
        withAnimation {
            offsets.map { activities[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately
                print("Error deleting activity: \(error.localizedDescription)")
            }
        }
    }

    // Date formatter for displaying dates
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
