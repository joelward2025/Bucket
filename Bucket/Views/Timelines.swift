import SwiftUI

// Model for a Bucket List item
struct BucketListItem: Identifiable {
    let id = UUID()
    let title: String
    let dateCompleted: Date
    let description: String
    let imageName: String? // Optional in case no specific image is provided
}

// Sample Data with Filler Images
let bucketListData = [
    BucketListItem(title: "Skydiving", dateCompleted: Date(), description: "Jumped out of a plane from 10,000 feet!", imageName: "sky"),
    BucketListItem(title: "Visited Paris", dateCompleted: Date().addingTimeInterval(-86400 * 10), description: "Saw the Eiffel Tower and ate delicious croissants.", imageName: "tower"),
    BucketListItem(title: "Learned to Surf", dateCompleted: Date().addingTimeInterval(-86400 * 30), description: "Caught my first wave in Hawaii.", imageName: "ocean")
]

// Helper to format dates
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

// Timeline view for displaying completed bucket list items
struct TimelineView: View {
    var items: [BucketListItem]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(items) { item in
                    TimelinePostView(item: item)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

// View for individual timeline posts
struct TimelinePostView: View {
    var item: BucketListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Load the image if one exists, otherwise load a default filler image
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(dateFormatter.string(from: item.dateCompleted))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.bottom, 5)
            
            Text(item.description)
                .font(.body)
                .padding(.bottom, 10)
            
            // Load the post image or a filler image if none is provided
            Image(item.imageName ?? "profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
        }
    }
}

struct TimelineContentView: View {
    var body: some View {
            NavigationView {
                TimelineView(items: bucketListData)
                    .navigationTitle("Bucket List Timeline")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                            }) {
                                Image(systemName: "arrow.left")
                                Text("Back")
                            }
                        }
                    }
            }
            Button(action: {
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
        }
}
#Preview {
    TimelineContentView()
}
