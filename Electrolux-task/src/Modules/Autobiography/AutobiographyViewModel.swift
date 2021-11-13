//
//  AutobiographyViewModel.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

struct AutobiographyViewModel {

    var avatarURL: URL?
    var firstName: String
    var lastName: String
    var biography: String

    init(photoURL: String, firstName: String, lastName: String, biography: String) {
        avatarURL = URL(string: photoURL)
        self.firstName = firstName
        self.lastName = lastName
        self.biography = biography
    }
}
