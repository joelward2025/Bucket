import SwiftUI

// Model for a Bucket List
struct BucketList: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let items: [BucketListItem]
}

// Sample Data for Bucket Lists
let sampleBucketLists = [
    BucketList(name: "Adventure Bucket List", emoji: "🪂", items: [
        BucketListItem(title: "Skydiving", dateCompleted: Date(), description: "Jumped out of a plane from 10,000 feet!", imageName: "skydiving_filler"),
        BucketListItem(title: "Climbed Everest", dateCompleted: Date().addingTimeInterval(-86400 * 365), description: "Reached the summit of Mount Everest!", imageName: "everest_filler")
    ]),
    BucketList(name: "Travel Bucket List", emoji: "✈️", items: [
        BucketListItem(title: "Visited Paris", dateCompleted: Date().addingTimeInterval(-86400 * 10), description: "Saw the Eiffel Tower and ate delicious croissants.", imageName: "paris_filler"),
        BucketListItem(title: "Road trip across the USA", dateCompleted: Date().addingTimeInterval(-86400 * 120), description: "Explored many states and famous landmarks.", imageName: "roadtrip_filler")
    ]),
    BucketList(name: "Career Goals", emoji: "💼", items: [
        BucketListItem(title: "Got promoted", dateCompleted: Date().addingTimeInterval(-86400 * 60), description: "Finally got the promotion I was working towards.", imageName: "promotion_filler")
    ])
]

// Standalone HomeView Component with Non-Navigating Buttons
struct HomeView: View {
    var bucketLists: [BucketList]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My Bucket Lists")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                List(bucketLists) { bucketList in
                    Button(action: {
                        // Action for button tap (no navigation)
                        print("\(bucketList.name) tapped")
                    }) {
                        HStack {
                            // Show the emoji for each bucket list
                            Text(bucketList.emoji)
                                .font(.largeTitle)
                            
                            // Show the name of each bucket list
                            Text(bucketList.name)
                                .font(.headline)
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove default button styling
                    .padding(.vertical, 10)
                }
                .listStyle(InsetGroupedListStyle()) // Apply a clean list style
                HStack{
                    // friends
                    Button(action: {
                    }) {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                    .padding(.bottom, 20)
                    // plus button
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
                    .padding()
                    .padding(.bottom, 20)
                    //
                    Button(action: {
                    }) {
                        Image(systemName: "gear")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding()
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeContentView: View {
    var body: some View {
        HomeView(bucketLists: sampleBucketLists)
    }
}

#Preview{
    HomeContentView()
}
