//
//  Movie.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/29/22.
//

import Foundation

struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String?
    let vote_average: Double
    let overview: String
    let vote_count:Int!
}
