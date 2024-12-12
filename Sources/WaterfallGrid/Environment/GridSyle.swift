//
//  Copyright © 2019 Paolo Leonardi.
//
//  Licensed under the MIT license. See the LICENSE file for more info.
//

import SwiftUI

struct GridStyle {
    @PositiveNumber var columnsInPortrait: Int
    @PositiveNumber var columnsInLandscape: Int

    let rowsSpacing: CGFloat
    let columnsSpacing: CGFloat
    let animation: Animation?

    var columns: Int {
        #if os(OSX) || os(tvOS) || targetEnvironment(macCatalyst) || os(visionOS)
        return columnsInLandscape
        #elseif os(watchOS)
        return columnsInPortrait
        #else
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width > screenSize.height ? columnsInLandscape : columnsInPortrait
        #endif
    }
}

struct GridStyleKey: EnvironmentKey {
    static let defaultValue = GridStyle(columnsInPortrait: 2,
                                        columnsInLandscape: 2,
                                        rowsSpacing: 8,
                                        columnsSpacing: 8,
                                        animation: .default)
}

extension EnvironmentValues {
    var gridStyle: GridStyle {
        get { self[GridStyleKey.self] }
        set { self[GridStyleKey.self] = newValue }
    }
}
