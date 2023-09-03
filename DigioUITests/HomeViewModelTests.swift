//
//  HomeViewModelTests.swift
//  DigioUITests
//
//  Created by Vandecarlos Santana on 02/09/23.
//

import XCTest
@testable import DigioUI

class HomeViewModelTests: XCTestCase {

    func testInit() {
      
        let viewModel = HomeViewModel()

        XCTAssertEqual(viewModel.name, "Olá! Maria ")
        XCTAssertNil(viewModel.cashUrl)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }

}
