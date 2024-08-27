import SwiftUI

struct TagSection: View {
    @StateObject var viewModel: TagSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.sectionTitle)
                .foregroundStyle(.gray)
                .font(.system(size: 14))
            HStack {
                ForEach(viewModel.sectionItems, id: \.self) { item in
                    Tag(viewModel: viewModel, tagTitle: item)
                }
            }
        }
        .padding(.bottom, 10)
    }
}

struct Tag: View {
    @StateObject var viewModel: TagSectionViewModel
    
    var tagTitle: String = ""
    
    var body: some View {
        Text(tagTitle)
            .font(.system(size: 14))
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 4)
            .background(viewModel.sectionSelectedState[(viewModel.sectionItems.firstIndex(of: tagTitle))!] ? Color(.lightGray) : .white)
            .cornerRadius(15)
            .foregroundStyle(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
            )
            .padding(2)
            .onTapGesture {
                viewModel.tagSelected(tagTitle: tagTitle)
            }
    }
}
