//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by metalnodeug on 30/06/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please chech your internet connection."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data receive from the server is invalid. Please try again."
}
