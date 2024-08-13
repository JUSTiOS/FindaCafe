//
//  CafeListView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/5/24.
//

import SwiftUI
import Combine
import CoreLocation

public struct CafeListView: View {
    enum Filter {
        case all
        case near
    }
    
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
            ZStack {
                VStack(spacing: 0) {
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
                                .padding()
                            }
                        }
                        .tint(.gray)
                        
                    }
                    
                    List($cafes, id: \.self) { cafe in
                        ZStack {
                            CafeListCellView(cafe: cafe)
                            
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
                        showFilterSelector = false
                    }
                }
                
                VStack {
                    // TODO: - Should be replaced to cafe board image
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 200, height: 200)
                    
                    Text("등록된 카페가 없습니다.\n나만의 카페를 등록해보세요!")
                }
                .opacity(cafes.isEmpty ? 1.0 : 0.0)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 0) {
                            Button(action: {
                                filter = .all
                                showFilterSelector = false
                            }) {
                                Text("전체")
                                    .padding()
                            }
                            
                            Rectangle()
                                .frame(maxWidth: 100, maxHeight: 1.5)
                            
                            Button(action: {
                                filter = .near
                                showFilterSelector = false
                            }) {
                                Text("내 주변")
                                    .padding()
                            }
                        }
                        .padding(.horizontal)
                        .foregroundStyle(.gray)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 15)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1.5)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .shadow(radius: 3, x: 3, y: 3)
                        )
                    }
                    .offset(x: -10, y: 45)
                    .opacity(showFilterSelector ? 1.0 : 0.0)
                    
                    Spacer()
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
