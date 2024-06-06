//
//  AboutView.swift
//  LorenzoStory
//
//  Created by JWSScott777 on 6/2/24.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Hey I'm...")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Image("Beast-BW")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.bottom, 10)

                Text("Lorenzo the Bulldog")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("""
                    Lorenzo is not your ordinary bulldog. Born with a heart of gold and a knack for adventure, Lorenzo's tales have captivated audiences of all ages. From mysterious quests to heartwarming love stories, his journeys are filled with excitement, intrigue, and a lot of heart.

                    This app is dedicated to bringing Lorenzo's stories to life. Each category explores a different facet of his world, showcasing his bravery, loyalty, and the unbreakable bond he shares with his friends. Whether you're diving into a thrilling mystery or enjoying a romantic escapade, Lorenzo's stories promise to entertain and inspire.

                    Explore the different categories and get to know Lorenzo and his adventures. Each book offers a unique glimpse into his life, filled with captivating narratives. Join Lorenzo on his journeys and discover why he's a beloved character in the hearts of many.
                    """)
                    .padding(.bottom, 20)

                Text("Categories")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("""
                    - **Mystery**: Unravel the secrets with Lorenzo as he solves intriguing mysteries.
                    - **Love**: Heartfelt stories of love and friendship that warm the soul.
                    - **Action**: High-energy adventures showcasing Lorenzo's bravery and quick thinking.
                    - **Adventure**: Epic journeys that take Lorenzo to far-off places and new experiences.
                    - **Fun**: Light-hearted tales that bring joy and laughter.
                    """)
                    .padding(.bottom, 20)

                Text("Thank You")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("""
                    Thank you for being a part of Lorenzo's journey. We hope you enjoy exploring his world as much as we enjoyed creating it. Your support and love for Lorenzo and his stories mean the world to us.
                    """)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                    })
                }
            }
        }//

    }
}

#Preview {
    AboutView()
}

