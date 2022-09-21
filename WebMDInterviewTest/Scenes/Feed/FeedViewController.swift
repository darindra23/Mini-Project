import Kingfisher
import RxCocoa
import RxSwift
import SnapKit
import UIKit

internal final class FeedViewController: UIViewController {
    // - MARK: View Model
    private let viewModel = FeedViewModel()
    private let disposeBag = DisposeBag()

    // - MARK: UI Component
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.tableFooterView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return view
    }()

    override internal func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
    }

    // - MARK: Bind View Model
    private func bindViewModel() {
        let input = FeedViewModel.Input(
            didLoad: .just(())
        )

        let output = viewModel.transform(input: input)

        output.items
            .drive(tableView.rx.items) { _, _, item in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

                cell.selectionStyle = .none
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

                cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                cell.textLabel?.text = item.title

                cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                cell.detailTextLabel?.textColor = .secondaryLabel
                cell.detailTextLabel?.text = item.description

                let image = UIImageView()
                image.kf.setImage(
                    with: item.imageURL,
                    completionHandler: { response in
                        guard case let .success(data) = response else { return }

                        cell.imageView?.image = data.image.resizeImage(width: 60, height: 40)
                        cell.setNeedsLayout()
                    }
                )

                return cell
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(FeedItemModel.self)
            .asDriver()
            .drive(onNext: { [weak self] item in
                guard let self = self else { return }

                let vc = FeedDetailViewController(data: item)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setupView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
