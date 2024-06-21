//
//  ImageStorage.swift
//  HomeFeature
//
//  Created by Jaehun Lee on 6/4/24.
//

import Foundation

protocol ImageStorage {
    func updateImage(of cafe: Cafe, to data: Data) async throws
    func removeImage(of cafe: Cafe) async throws
}
