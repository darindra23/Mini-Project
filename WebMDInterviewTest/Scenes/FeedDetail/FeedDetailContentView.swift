//
//  FeedDetailContentView.swift
//  WebMDInterviewTest
//
//  Created by darindra.khadifa on 11/09/22.
//

import Kingfisher
import SnapKit
import UIKit

class FeedDetailContentView: UIView {
    // - MARK: UI Component
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var descriptionView: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var detailView: UILabel = {
        let view = UILabel(frame: .zero)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    internal init(data: FeedItemModel) {
        super.init(frame: .zero)

        descriptionView.text = data.description
        detailView.text = data.detail

        imageView.isHidden = data.imageURL == nil
        imageView.kf.setImage(with: data.imageURL)

        setupView()
    }

    internal required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        addSubview(descriptionView)
        descriptionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)

            if imageView.isHidden {
                make.top.equalToSuperview().inset(16)
            } else {
                make.top.equalTo(imageView.snp.bottom).offset(16)
            }
        }

        addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(descriptionView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
