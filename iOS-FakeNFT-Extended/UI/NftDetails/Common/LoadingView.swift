import ProgressHUD
import UIKit

@MainActor
protocol LoadingView: AnyObject {
    var activityIndicator: UIActivityIndicatorView { get }
    func showLoading()
    func hideLoading()
}

@MainActor
extension LoadingView {
    func showLoading() {
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
    }
}
