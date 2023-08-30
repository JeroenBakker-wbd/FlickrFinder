//
//  Created by Jeroen Bakker on 30/08/2023.
//  Copyright (c) 2023 Bleacher Report. All rights reserved.
//

import XCTest
import Factory
@testable import Data

final class DataInjectionTests: XCTestCase {

    func test_singletons_onUrlSession_shouldReturnSameReference() {
        // given
        Container.registerAllServices()

        // when
        let urlSession1 = Container.Singletons.urlSession.callAsFunction() as? URLSession
        let urlSession2 = Container.Singletons.urlSession.callAsFunction() as? URLSession

        // then
        XCTAssertTrue(urlSession1 === urlSession2)
    }

    func test_workers_onAPI_shouldReturnService() {
        // given
        Container.registerAllServices()

        // when
        let result = Container.Workers.api.callAsFunction()

        // then
        XCTAssertTrue(result is APIService)
    }

    func test_mappers_onSearchPhotoResult_shouldReturnMapper() {
        // given
        Container.registerAllServices()

        // when
        let result = Container.Mappers.searchPhotosResult.callAsFunction()

        // then
        XCTAssertNotNil(result)
    }

    func test_mappers_onPhoto_shouldReturnMapper() {
        // given
        Container.registerAllServices()

        // when
        let result = Container.Mappers.photo.callAsFunction()

        // then
        XCTAssertNotNil(result)
    }
}
