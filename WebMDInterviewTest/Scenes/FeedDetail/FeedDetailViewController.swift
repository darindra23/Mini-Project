//
//  FeedDetailViewController.swift
//  WebMDInterviewTest
//
//  Created by darindra.khadifa on 11/09/22.
//

import Kingfisher
import SnapKit
import UIKit

internal final class FeedDetailViewController: UIViewController {
    // - MARK: Data Source
    private let data: FeedItemModel

    // - MARK: UI Component
    private let scrollView = UIScrollView()
    private let detailContent: FeedDetailContentView

    internal init(data: FeedItemModel) {
        self.data = data
        self.detailContent = FeedDetailContentView(data: data)

        super.init(nibName: nil, bundle: nil)

        title = data.title
    }

    internal required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override internal func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupView()
    }

    private func setupView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(detailContent)
        detailContent.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
