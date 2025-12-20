import UIKit

extension UIFont {
    // Ниже приведены примеры шрифтов, настоящие шрифты надо взять из фигмы

    // Headline Fonts
    static let headline1 = UIFont.systemFont(ofSize: 34, weight: .bold)
    static let headline2 = UIFont.systemFont(ofSize: 28, weight: .bold)
    static let headline3 = UIFont.systemFont(ofSize: 22, weight: .bold)
    static let headline4 = UIFont.systemFont(ofSize: 20, weight: .bold)

    // Body Fonts
    static let bodyRegular = UIFont.systemFont(ofSize: 17, weight: .regular)
    static let bodyBold = UIFont.systemFont(ofSize: 17, weight: .bold)

    // Caption Fonts
    static let caption1 = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let caption2 = UIFont.systemFont(ofSize: 13, weight: .regular)
}
