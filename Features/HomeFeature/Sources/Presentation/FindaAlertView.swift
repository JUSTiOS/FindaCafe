//
//  FindaAlertView.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 7/3/24.
//

import SwiftUI

struct FindaAlertView: View {
    @Binding var isPresented: Bool
    
    private let title: String?
    private let description: String?
    private let cancelText: String?
    private let confirmText: String
    private let cancelAction: (() -> ())?
    private let confirmAction: (() -> ())?
    
    public init(
        isPresented: Binding<Bool>,
        title: String?,
        description: String?,
        cancelText: String?,
        confirmText: String,
        cancelAction: (() -> ())?,
        confirmAction: (() -> ())?
    ) {
        self._isPresented = isPresented
        self.title = title
        self.description = description
        self.confirmText = confirmText
        self.cancelText = cancelText
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let title {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            if let description {
                Text(description)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .padding()
            }
            
            HStack(spacing: 0) {
                if let cancelText {
                    Button(action: {
                        if let cancelAction {
                            cancelAction()
                        }
                    }) {
                        Text(cancelText)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.gray)
                            )
                            .padding()
                    }
                }
                
                Button(action: {
                    if let confirmAction {
                        confirmAction()
                    }
                }) {
                    Text(confirmText)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.black)
                        )
                        .padding()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
        )
    }
}
