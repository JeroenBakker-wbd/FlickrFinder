//
//  Created by Jeroen Bakker on 28/08/2023.
//  Copyright (c) 2023 Bleacher Report. All rights reserved.
//

import XCTest
@testable import Data

final class FlickrSearchPhotoErrorTests: XCTestCase {

    func test_init_onUnsupportedInput_shouldReturnAPIEnum() throws {
        // given
        let input = 0

        // when
        let result = FlickrSearchPhotoError(rawValue: input)

        // then
        if case .api(let flickrAPIError) = result {
            XCTAssertEqual(.unknown, flickrAPIError)
        } else {
            XCTFail()
        }
    }

    func test_Init_onSupportedInputs_shouldReturnEnum() throws {
        // given
        let inputs = [1, 2, 3, 4, 5]
        let expectedResults: [FlickrSearchPhotoError] = [
            .tooManyTags,
            .unknownUser,
            .parameterlessSearchesDisabled,
            .noPermission,
            .userDeleted
        ]

        for (index, input) in inputs.enumerated() {
            // when
            let result = FlickrSearchPhotoError(rawValue: input)
            // then
            XCTAssertEqual(expectedResults[index], result)
        }
    }
}
