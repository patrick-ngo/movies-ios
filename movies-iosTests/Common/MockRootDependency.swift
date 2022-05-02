//
//  MockRootDependency.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation
@testable import movies_ios

final class MockRootDependency: RootDependency {
  var movieService: MovieService = MockMovieService()
}
