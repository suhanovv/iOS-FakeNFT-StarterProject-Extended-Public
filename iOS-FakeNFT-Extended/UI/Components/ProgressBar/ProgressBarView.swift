import SwiftUI

struct ProgressBarView: View {
    let isActive: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 82, height: 82)
            .foregroundStyle(.progressBar)
            .overlay {
                ProgressView()
                    .scaleEffect(1.5)
            }
            .opacity(isActive ? 1 : 0)
    }
}

#Preview {
    ProgressBarView(isActive: true)
}
