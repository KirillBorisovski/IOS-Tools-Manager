//
//  ToolsContainer.swift
//  
//
//  Created by Борисов Кирилл Анатольевич on 18.03.2022.
//

import SwiftUI
import Models

/// The state of ToolsContainer
public enum ToolsContainerState {
    case resized
    case `default`

    public mutating func toggle() {
        self = self == .default ? .resized : .default
    }
}

@available(iOS 14.0.0, *)
/// The view container for circle view items.
public struct ToolsContainer: View {

    // MARK: - Constants

    private enum Constants {
        static let showIndicators = false
        static let spacing: CGFloat = 16
        static let blurRadius: CGFloat = 0.4
    }

    // MARK: - Public properties

    @Binding public var state: ToolsContainerState

    // MARK: - Private properties

    @Binding private var items: [ContainerItem]
    private var onItemTapAction: ((Int) -> ())?

    // MARK: - Computed Properties

    private var shownItems: [ContainerItem] {
        guard items.count > 3 else { return items }
        return state == .default ? Array(items[0..<4]) : items
    }

    private var columns: [GridItem] {
        let spacing = state == .default ? Constants.spacing : Constants.spacing * 7
        return [
            GridItem(.fixed(55), spacing: spacing),
            GridItem(.fixed(55), spacing: spacing)
        ]
    }

    private var spacing: CGFloat {
        state == .default ? 16 : 32
    }

    // MARK: - Initializer

    public init(
        items: Binding<[ContainerItem]>,
        state: Binding<ToolsContainerState>,
        onItemTapAction: ((Int) -> ())?
    ) {
        self.onItemTapAction = onItemTapAction
        self._items = items
        self._state = state
    }

    // MARK: - Layout

    public var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: spacing
        ) {
            ForEach(Array(0..<shownItems.count), id: \.self) { index in
                ToolsItemView(
                    item: shownItems[index],
                    isTextBlockHidden: state == .default,
                    isSelected: shownItems[index].isSelected
                )
                .onTapGesture { onItemTapAction?(index) }
            }
        }
        .padding(spacing)
        .fixedSize(horizontal: state == .default, vertical: false)
        .background(Color.black)
        .opacity(Constants.blurRadius)
        .clipShape(RoundedCorner(radius: 25, corners: .allCorners))
        .onTapGesture { state.toggle() }
        .onLongPressGesture{ state.toggle() }
        .animation(.default, value: state)
    }


}

@available(iOS 14.0.0, *)
private struct RoundedCorner: Shape {

    // MARK: - Internal properties

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    // MARK: - Internal methods

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }

}
