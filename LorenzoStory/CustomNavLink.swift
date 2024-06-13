//
//  CustomNavLink.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/12/24.
//

import SwiftUI

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct CustomNavLinkView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    var title: String
    var content: Content
    @State var Yoffset: CGFloat = 0
    var action: () -> Void
    init(title: String, @ViewBuilder content: () -> Content, action: @escaping () -> Void) {
        self.title = title
        self.content = content()
        self.action = action
    }
    var body: some View {
        content
            .ignoresSafeArea()
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                }
            )
            .safeAreaPadding(.top)
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                Yoffset = max(0.8, min(1, value / 100))
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title).bold().font(.title)
                        .scaleEffect(Yoffset)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                   bookmark
                }
            }
    }
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left").bold().foregroundStyle(.white)
                .frame(width: 55, height: 55)
                .background(.ultraThinMaterial, in: Circle())
                .scaleEffect(Yoffset)
        })
    }
    private var bookmark: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "pawprint").bold().foregroundStyle(.white)
                .frame(width: 55, height: 55)
                .background(.ultraThinMaterial, in: Circle())
                .scaleEffect(Yoffset)
        })
    }
}

//#Preview {
//    CustomNavLink()
//}

