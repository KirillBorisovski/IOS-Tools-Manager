//
//  File.swift
//  
//
//  Created by Борисов Кирилл Анатольевич on 18.03.2022.
//

import SwiftUI

@available(iOS 14.0, *)
public struct ContainerItem: Hashable {

    // MARK: - Public Properties

    public var id = UUID().uuidString
    public var title: String
    public var description: String
    public var image: Image?
    public var isSelected: Bool

    // MARK: - Initializer

    public init(
        title: String,
        description: String,
        image: Image? = nil,
        isSelected: Bool = false
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.isSelected = false
    }

    // MARK: - Public methods

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(description)
        hasher.combine(title)
    }

    public static func == (lhs: ContainerItem, rhs: ContainerItem) -> Bool {
        lhs.id == rhs.id
    }

}
