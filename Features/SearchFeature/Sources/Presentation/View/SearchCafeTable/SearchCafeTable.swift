import SwiftUI

struct SearchCafeTable: View {
    @ObservedObject var viewModel: SearchCafeTableViewModel
    
    var myLocation: MyLocationEntity
    
    var body: some View {
        VStack {
            List {
                if viewModel.update {
                    ForEach(viewModel.nearbyCafes, id: \.id) { cafe in
                        SearchCafeTableCell(nearbyCafe: cafe)
                    }
                    .listStyle(.plain)
                }
            }
            .listStyle(.plain)
        }.onAppear {
            viewModel.getNearbyCafeList(myLocation: myLocation)
        }
    }
}

struct SearchCafeTableCell: View {
    var nearbyCafe: NearbyCafeEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(nearbyCafe.cafeName)
                    .font(.system(size: 16))
                    .bold()
                Text(nearbyCafe.address)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("\(nearbyCafe.distance) m")
                .font(.system(size: 16))
                .foregroundStyle(.orange)
        }.frame(height: 40)
    }
}
