//
//  GHFError.swift
//  GHFollowers
//
//  Created by metalnodeug on 03/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import Foundation

enum GHFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please chech your internet connection."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data receive from the server is invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorite = "This user is already in favorite, you can't add this user too"
}
