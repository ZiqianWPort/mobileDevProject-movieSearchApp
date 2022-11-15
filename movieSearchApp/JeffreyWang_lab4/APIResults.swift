//
//  APIResults.swift
//  JeffreyWang_lab4
//
//  Created by Ziqian Wang on 10/29/22.
//

import Foundation

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}
