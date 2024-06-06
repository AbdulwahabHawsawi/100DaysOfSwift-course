//
//  RatingView.swift
//  Bookworm
//
//  Created by Abdulwahab Hawsawi on 20/04/2024.
//

import SwiftUI

struct RatingView: View {
    var maximumRating = 5
    var label = ""
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundStyle(number > rating ? offColor : onColor )
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
    
    func image(for number: Int) -> Image? {
        if number > rating {
            return offImage ?? onImage
        }
        
        return onImage
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
