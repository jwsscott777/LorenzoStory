//
//  IntroPage.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/1/24.
//

import SwiftUI

struct IntroPage: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            IntroView(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    IntroPage()
}
