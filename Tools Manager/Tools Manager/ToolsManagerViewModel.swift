//
//  ToolsManagerViewModel.swift
//  Tools Manager
//
//  Created by Борисов Кирилл Анатольевич on 18.03.2022.
//

import Combine
import SwiftUI
import Models
import UI

final class ToolsManagerViewModel: ObservableObject {

    // MARK: - Published Properties.

    @Published var items: [ContainerItem] = [
        .init(title: "Wifi", description: "Private", image: Image(systemName: "wifi")),
        .init(title: "Clock", description: "21:21", image: Image(systemName: "clock")),
        .init(title: "Mic", description: "On", image: Image(systemName: "mic")),
        .init(title: "Name", description: "ME", image: Image(systemName: "person")),
        .init(title: "Car", description: "BMW", image: Image(systemName: "car")),
        .init(title: "Player", description: "Pause", image: Image(systemName: "pause"))
    ]

    @Published var didSelectItem: Int?
    @Published var state: ToolsContainerState = .default

    // MARK: - Private Properties.

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer.

    init() {
        bindPublishers()
    }

    // MARK: - Binding.

    private func bindPublishers() {
        $state
            .dropFirst()
            .sink { [weak self] _ in self?.simpleSuccessSound() }
            .store(in: &cancellables)

        $didSelectItem
            .sink { [weak self] index in
                guard let index = index else { return }
                self?.items[index].isSelected.toggle()
            }
            .store(in: &cancellables)
    }

    // MARK: - Private methods.

    private func simpleSuccessSound() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

}
