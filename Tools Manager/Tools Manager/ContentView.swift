//
//  ContentView.swift
//  Tools Manager
//
//  Created by Борисов Кирилл Анатольевич on 18.03.2022.
//

import SwiftUI
import Models
import UI

struct ContentView: View {

    // MARK: - Constants

    private enum Constants {
        static let padding: CGFloat = 16
    }

    // MARK: - Properties

    @StateObject private var viewModel = ToolsManagerViewModel()

    // MARK: - Layout

    var body: some View {
        VStack {
            HStack {
                ToolsContainer(
                    items: $viewModel.items,
                    state: $viewModel.state,
                    onItemTapAction: { index in viewModel.didSelectItem = index }
                )
                Spacer()
            }
            .padding(Constants.padding)
            Spacer()
        }
        .onTapGesture { viewModel.state = .default }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
