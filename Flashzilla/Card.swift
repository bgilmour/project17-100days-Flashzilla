//
//  Card.swift
//  Flashzilla
//
//  Created by Bruce Gilmour on 2021-08-16.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
