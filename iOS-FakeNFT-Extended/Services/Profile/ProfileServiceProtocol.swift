//
//  P.swift
//  iOS-FakeNFT-Extended
//
//  Created by Ди Di on 05/12/25.
//

protocol ProfileServiceProtocol {
    func fetchProfile(id: String) async throws -> Profile
    func updateProfile(id: String, with request: ProfileUpdateRequest) async throws -> Profile
}
