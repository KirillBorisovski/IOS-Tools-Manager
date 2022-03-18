//
//  File.swift
//  
//
//  Created by Борисов Кирилл Анатольевич on 18.03.2022.
//

import SwiftUI
import Models

@available(iOS 14.0.0, *)
/// The tools item view with description and title text.
public struct ToolsItemView: View {

    // MARK: - Constants

    private enum Constants {
        static let showIndicators = false
        static let imageSize: CGFloat = 50
        static let textSpacing: CGFloat = 2
        static let titleSize: CGFloat = 4
        static let descriptionSize: CGFloat = 3
        static let spacing: CGFloat = 8
    }

    // MARK: - Private properties

    private let item: ContainerItem
    private let isTextBlockHidden: Bool
    private let isSelected: Bool

    // MARK: - Initializer

    public init(
        item: ContainerItem,
        isTextBlockHidden: Bool,
        isSelected: Bool
    ) {
        self.item = item
        self.isTextBlockHidden = isTextBlockHidden
        self.isSelected = isSelected
    }

    // MARK: - Layout

    public var body: some View {
        VStack(spacing: Constants.spacing) {
            ZStack {
                Circle()
                    .fill(isSelected ? Color.green : Color.accentColor)
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                item.image?
                    .foregroundColor(Color.white)
            }

            if !isTextBlockHidden {
                VStack(spacing: Constants.textSpacing) {
                    Text(item.title)
                        .fontWeight(.bold)
                    Text(item.description)
                        .fontWeight(.light)
                }
                .lineLimit(.zero)
                .font(.headline)
                .foregroundColor(.white)
            }
        }
    }

}
