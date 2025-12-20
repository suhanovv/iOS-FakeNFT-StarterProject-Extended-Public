import SwiftUI

struct TestCatalogView: View {
    @Environment(ServicesAssembly.self) var servicesAssembly
    @State private var presentingNft = false
    @State private var selectedNftId: String?

    var body: some View {
        Button {
            selectedNftId = "7773e33c-ec15-4230-a102-92426a3a6d5a"
            presentingNft = true
        } label: {
            Text(Constants.openNftTitle)
                .tint(.blue)
        }
        .sheet(isPresented: $presentingNft) {
            if let id = selectedNftId {
                NftDetailBridgeView(nftId: id)
            }
        }
    }

    func showNft() {
        presentingNft = true
    }
}

private enum Constants {
    static let openNftTitle = NSLocalizedString("Catalog.openNft", comment: "")
}
