//
//  File.swift
//  
//
//  Created by Ihwan ID on 10/02/21.
//

import Foundation
import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
