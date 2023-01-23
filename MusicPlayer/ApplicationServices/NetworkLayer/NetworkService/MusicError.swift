import Foundation

enum MusicError: String, Error {

    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidURL = "The url is broken"
    case invalidData = "The data received from the server was invalid. Please try again."

}
