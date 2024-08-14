import SwiftUI

struct TagSection: View {
    var sectionTitle: String = ""
    var sectionItems: [String] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sectionTitle)
                .foregroundStyle(.gray)
                .font(.system(size: 14))
            HStack {
                ForEach(sectionItems, id: \.self){ item in
                    Tag(sectionTitle: sectionTitle, tagTitle: item)
                }
            }
        }
        .padding(.bottom, 10)
    }
}

struct Tag: View {
    @State var selected: Bool = false
    
    var sectionTitle: String = ""
    var tagTitle: String = ""
    
    var body: some View {
        Text(tagTitle)
            .font(.system(size: 14))
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 4)
            .background(selected ? Color(.lightGray) : .white)
            .cornerRadius(15)
            .foregroundStyle(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 2)
            )
            .padding(2)
            .onTapGesture {
                selected.toggle()
                if selected {
                    print("key: \(sectionTitle), tag: \(tagTitle)")
                } else {
                    print("key: \(sectionTitle), tag: \(tagTitle)")
                }
            }
    }
}
