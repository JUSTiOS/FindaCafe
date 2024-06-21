//
//  CafeListView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/5/24.
//

import SwiftUI
import Combine
import CoreLocation

enum Filter {
    case all
    case near
}

public struct CafeListView: View {
    private let loadCafeListUseCase: LoadCafeListUseCase
    
    public init(loadCafeListUseCase: LoadCafeListUseCase) {
        self.loadCafeListUseCase = loadCafeListUseCase
    }
    
    @State var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    @State var location: CLLocation = .init()
    
    @State private var filter: Filter = .all
    @State private var showFilterSelector: Bool = false
    
    @State private var cafes: [Cafe] = []
    
    public var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // TODO: - Should be replaced by FINDA Image
                    Text("Butter Coffee")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    ZStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                showFilterSelector.toggle()
                            }) {
                                Text(filter == .all ? "전체" : "내 주변")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                        }
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                Button(action: {
                                    filter = .all
                                    showFilterSelector = false
                                }) {
                                    Text("전체")
                                }
                                .padding(.top)
                                
                                Divider()
                                    .frame(maxWidth: 100)
                                
                                Button(action: {
                                    filter = .near
                                    showFilterSelector = false
                                }) {
                                    Text("내 주변")
                                }
                                .padding(.bottom)
                            }
                            .padding(.horizontal)
                            .clipShape(.rect(cornerRadius: 15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.gray, lineWidth: 1.5)
                            )
                        }
                        .offset(y: 40)
                        .opacity(showFilterSelector ? 1.0 : 0.0)
                    }
                    .tint(.gray)
                    
                }
                .background(.brown)
                
                List(cafes, id: \.self) { cafe in
                    ZStack {
                        HStack {
                            Rectangle()
                                .foregroundStyle(.brown)
                                .frame(width: 85, height: 85)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(cafe.name)
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                
                                Text(cafe.address)
                                    .font(.system(size: 10))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.gray)
                                    .lineLimit(1)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    ForEach(Array(cafe.tags), id: \.self) { tag in
                                        TagView(tag: tag)
                                    }
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            
                            Spacer()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1.5)
                        )
//                        .shadow(radius: 3, x: 3, y: 3)
                        
                        NavigationLink(destination: CafeDetailView(cafe: cafe)) {
                            EmptyView()
                        }
                        .opacity(.zero)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .refreshable {
                    
                }
            }
        }
        .task {
            do {
                cafes = try await loadCafeListUseCase.execute()
            } catch {
                print("error occured")
            }
        }
    }
}

struct TagView: View {
    let tag: Tag
    
    var body: some View {
        Text(tag.name)
            .font(.system(size: 9))
            .fontWeight(.bold)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            )
    }
}

#Preview {
    struct PreviewView: View {
        var body: some View {
            CafeListView(loadCafeListUseCase: LoadCafeListUseCaseImpl(repository: CafeRepositoryImpl(persistentStorage: CoreDataCafeStorage(coreDataStorage: CoreDataStorage(inMemory: true)))))
        }
    }
    
    return PreviewView()
}

