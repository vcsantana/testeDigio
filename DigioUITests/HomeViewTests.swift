//
//  HomeViewTests.swift
//  DigioUITests
//
//  Created by Vandecarlos Santana on 02/09/23.
//

import XCTest
@testable import DigioUI

class HomeViewTests: XCTestCase {
    var viewModel: HomeViewModel!
    var homeView: HomeView!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        homeView = HomeView(viewModel: viewModel)
    }

    override func tearDown() {
        viewModel = nil
        homeView = nil
        super.tearDown()
    }


}

