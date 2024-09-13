import SwiftUI

struct BackButton: View {
    var body: some View {
        HStack {
            Button(action: {
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 24, weight: .bold))
            }
            .padding()
            Spacer()
        }
    }
}

struct EventName: View {
    @State private var eventName: String = ""
    var body: some View {
        TextField("Enter event name", text: $eventName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.gray, width: 1)
            .padding(.horizontal)
    }
}

struct Description: View {
    @State private var eventDescription: String = ""
    var body: some View {
        TextEditor(text: $eventDescription)
            .frame(height: 150)
            .border(Color.gray, width: 1)
            .padding(.horizontal)
    }
}

struct DateSelector: View {
    @State private var eventDate: Date = Date()
    var body: some View {
        DatePicker(
            "Select event date",
            selection: $eventDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(CompactDatePickerStyle())
        .padding(.horizontal)
    }
}

struct Rating: View {
    var body: some View {
        HStack {
            
            Text("Rating: ")
            Spacer()
            ForEach(1..<6) { star in
                Image(systemName: "star.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        // Action for rating stars
                    }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

struct AddImages: View {
    var body: some View {
        // Upload Images Button
        Button(action: {
            // Action for uploading images
        }) {
            HStack {
                Image(systemName: "photo.on.rectangle.angled")
                Text("Upload Images")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct TagFriends: View {
    var body: some View {
        // Upload Images Button
        Button(action: {
            // Action for uploading images
        }) {
            HStack {
                Image(systemName: "person.fill.badge.plus")
                Text("Tag friends")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct Location: View {
    var body: some View {
        // Upload Images Button
        Button(action: {
            // Action for uploading images
        }) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text("Add location")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct AddEvent: View {
    var body: some View {
        Button(action: {
        }) {
            Text("Add Event")
                .font(.headline)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            BackButton()
            NavigationView {
                VStack(spacing: 10) {
                    EventName()
                    Description()
                    DateSelector()
                    Rating()
                    AddImages()
                    HStack{
                        TagFriends()
                        Location()
                    }
                    AddEvent()
                }
                .navigationTitle("Create Event")
            }
        }
    }
}

#Preview {
    ContentView()
}
