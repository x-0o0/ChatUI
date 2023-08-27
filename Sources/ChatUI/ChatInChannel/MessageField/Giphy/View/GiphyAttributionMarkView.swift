import SwiftUI

class CustomTabBarController: UITabBarController {
    var tabBarHeight: CGFloat {
        tabBar.frame.size.height
    }
}

struct GiphyAttributionMarkView: View {

    private let paddingAboveTab = 2.5

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                Image(getImageName() , bundle: .module)
                    .padding(
                        .bottom, 
                        CustomTabBarController().tabBarHeight + paddingAboveTab
                    )
            }
        }
    }

    private func getImageName() -> String {
        colorScheme == .dark
        ? "Poweredby_100px-Black_VertText"
        : "Poweredby_100px-White_VertText"
    }

}
