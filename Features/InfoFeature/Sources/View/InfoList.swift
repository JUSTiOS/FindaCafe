import SwiftUI

enum Info {
    case faq
    case userGuide
    case opensourceLicense
    case ask
}

struct InfoList: Identifiable {
    let id: Info
    let title: String
}

struct InfoListView: View {
    let list: InfoList
    
    var body: some View {
        NavigationLink(destination: InfoListDetailView(list: list)) {
            HStack {
                Text(list.title)
                    .font(.system(size: 14))
                Spacer()
            }
        }
    }
}

struct InfoListDetailView: View {
    var list: InfoList
    
    var body: some View {
        switch list.id {
        case .faq:
            return sampleView()
        case .userGuide:
            return sampleView()
        case .opensourceLicense:
            return sampleView()
        case .ask:
            return sampleView()
        }
    }
}

struct sampleView: View {
    var body: some View {
        Text("Hi")
    }
}
