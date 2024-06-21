//
//  ImageRepositoryImpl.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

final class ImageRepositoryImpl {
    private let persistentStorage: ImageStorage
    
    init(persistentStorage: ImageStorage) {
        self.persistentStorage = persistentStorage
    }
}
