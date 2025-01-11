//
//  ErrorView.swift
//  Quotely
//
//  Created by Michael Winkler on 10.01.25.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry", action: retryAction)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    ErrorView(errorMessage: "Etwas ist schiefgelaufen!") {
        print("Retry tapped!")
    }
}
