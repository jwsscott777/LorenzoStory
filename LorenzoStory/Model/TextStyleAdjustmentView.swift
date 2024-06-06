//
//  TextStyleAdjustmentView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/2/24.
//

import SwiftUI

struct TextStyleAdjustmentView: View {
    @Binding var fontSize: CGFloat
    @Binding var fontColor: Color
    

    var defaultFontSize: CGFloat = 20
    var defaultFontColor: Color = .white
    var body: some View {
            VStack {
                Text("Adjust Font size")
                    .font(.largeTitle).bold()
                    .padding(.bottom, 25)
                HStack(spacing: 30) {
                    Text("<----Smaller Font")
                        .foregroundStyle(.red)
                    Text("Larger Font--->")
                        .foregroundStyle(.blue)
                }
                Slider(value: $fontSize, in: 17...50, step: 1) {
                    Text("Font Size: \(Int(fontSize), specifier: "%.1f")")
                        .foregroundStyle(.primary)
                }

                .padding()
                Text("Adjust Font Color")
                    .font(.largeTitle).bold()
                    .padding(.bottom, 25)
                ColorPicker("Font Color", selection: $fontColor)
                    .padding()
                Button("Reset to Default") {
                    fontSize = defaultFontSize
                    fontColor = defaultFontColor
                }
                Spacer()
            }
            .padding()
        }
    }


//#Preview {
//    TextStyleAdjustmentView()
//}
