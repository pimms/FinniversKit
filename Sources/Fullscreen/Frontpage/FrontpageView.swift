//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

public protocol FrontpageViewDelegate: AnyObject {
    func frontpageViewDidSelectRetryButton(_ frontpageView: FrontpageView)
}

public final class FrontpageView: UIView {
    public var model: FrontpageViewModel? {
        didSet {
            headerLabel.text = model?.adsGridViewHeaderTitle
            adsRetryView.set(labelText: model?.noRecommendationsText, buttonText: model?.retryButtonTitle)
            inlineConsentView.yesButtonTitle = model?.inlineConsentYesButtonTitle ?? ""
            inlineConsentView.infoButtonTitle = model?.inlineConsentInfoButtonTitle ?? ""
        }
    }

    private weak var delegate: FrontpageViewDelegate?
    private var didSetupView = false

    // MARK: - Subviews

    private let marketsGridView: MarketsGridView
    private let adsGridView: AdsGridView
    private lazy var headerView = UIView()

    private lazy var inlineConsentView: InlineConsentView = {
        let view = InlineConsentView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private lazy var headerLabel: Label = {
        var headerLabel = Label(style: .title3)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()

    private lazy var adsRetryView: FrontpageRetryView = {
        let view = FrontpageRetryView()
        view.delegate = self
        return view
    }()

    private var headerLabelBottom: NSLayoutConstraint?
    private var inlineConsentViewBottom: NSLayoutConstraint?

    // MARK: - Init

    public convenience init(delegate: FrontpageViewDelegate & MarketsGridViewDelegate & MarketsGridViewDataSource & AdsGridViewDelegate & AdsGridViewDataSource & InlineConsentViewDelegate) {
        self.init(delegate: delegate, marketsGridViewDelegate: delegate, marketsGridViewDataSource: delegate, adsGridViewDelegate: delegate, adsGridViewDataSource: delegate, inlineConsentViewDelegate: delegate)
    }

    public init(delegate: FrontpageViewDelegate, marketsGridViewDelegate: MarketsGridViewDelegate, marketsGridViewDataSource: MarketsGridViewDataSource, adsGridViewDelegate: AdsGridViewDelegate, adsGridViewDataSource: AdsGridViewDataSource, inlineConsentViewDelegate: InlineConsentViewDelegate) {
        marketsGridView = MarketsGridView(delegate: marketsGridViewDelegate, dataSource: marketsGridViewDataSource)
        marketsGridView.translatesAutoresizingMaskIntoConstraints = false

        adsGridView = AdsGridView(delegate: adsGridViewDelegate, dataSource: adsGridViewDataSource)
        adsGridView.translatesAutoresizingMaskIntoConstraints = false

        super.init(frame: .zero)
        inlineConsentView.delegate = inlineConsentViewDelegate
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    public override func layoutSubviews() {
        super.layoutSubviews()

        if didSetupView == false {
            setup()
            didSetupView = true
        }
    }

    public func reloadData() {
        reloadMarkets()
        reloadAds()
    }

    public func reloadMarkets() {
        marketsGridView.reloadData()
        setupAdsHeaderFrame()
        adsGridView.reloadData()
        setupAdsRetryView()
    }

    public func reloadAds() {
        adsRetryView.state = .hidden
        adsGridView.reloadData()
    }

    public func showAdsRetryButton() {
        adsRetryView.state = .labelAndButton
    }

    public func showInlineConsents(withText text: String) {
        inlineConsentView.isHidden = false
        inlineConsentView.descriptionText = text
        setupAdsHeaderFrame()
        invalidateLayout()
    }

    public func hideInlineConsents() {
        inlineConsentView.isHidden = true
        inlineConsentView.descriptionText = ""
        setupAdsHeaderFrame()
        invalidateLayout()
    }

    public func invalidateLayout() {
        adsGridView.invalidateLayout()
    }

    public func scrollToTop() {
        adsGridView.scrollToTop()
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .milk

        addSubview(adsGridView)
        addSubview(adsRetryView)

        headerView.addSubview(marketsGridView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(inlineConsentView)

        let maxInlineConsentViewWidth: CGFloat = 414.0
        let inlineConsentViewWidth = inlineConsentView.widthAnchor.constraint(equalToConstant: maxInlineConsentViewWidth)
        inlineConsentViewWidth.priority = UILayoutPriority(rawValue: 999)

        headerLabelBottom = headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -.mediumSpacing)
        inlineConsentViewBottom = headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -.mediumSpacing)

        NSLayoutConstraint.activate([
            marketsGridView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: .mediumLargeSpacing),
            marketsGridView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            marketsGridView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),

            headerLabel.topAnchor.constraint(equalTo: marketsGridView.bottomAnchor, constant: .mediumSpacing),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: .mediumLargeSpacing),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -.mediumLargeSpacing),

            inlineConsentView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: .mediumSpacing),
            inlineConsentView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            inlineConsentView.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: .mediumLargeSpacing),
            inlineConsentView.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -.mediumLargeSpacing),
            inlineConsentViewWidth
        ])

        adsGridView.fillInSuperview()
        adsGridView.headerView = headerView

        setupAdsHeaderFrame()
        setupAdsRetryView()
    }

    private func setupAdsHeaderFrame() {
        let inlineConsentViewHeight: CGFloat = {
            guard !inlineConsentView.isHidden else { return 0.0 }
            let inlineConsentViewHeight = inlineConsentView.intrinsicContentSize.height
            return inlineConsentViewHeight + .largeSpacing
        }()

        let headerTopSpacing: CGFloat = .largeSpacing
        let headerBottomSpacing: CGFloat = .mediumLargeSpacing
        let headerHeight = headerLabel.intrinsicContentSize.height
        let marketGridViewHeight = marketsGridView.calculateSize(constrainedTo: bounds.size.width).height
        let height = headerTopSpacing + headerBottomSpacing + headerHeight + marketGridViewHeight + inlineConsentViewHeight

        headerView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: height)

        headerLabelBottom?.isActive = inlineConsentView.isHidden
        inlineConsentViewBottom?.isActive = !inlineConsentView.isHidden
        layoutIfNeeded()
    }

    private func setupAdsRetryView() {
        let yCoordinate = headerView.bounds.height + .veryLargeSpacing
        adsRetryView.frame.size.height = 200
        adsRetryView.frame.size.width = bounds.width
        adsRetryView.frame.origin = CGPoint(x: 0, y: yCoordinate)
    }
}

// MARK: - FrontpageRetryViewDelegate

extension FrontpageView: FrontpageRetryViewDelegate {
    func frontpageRetryViewDidSelectButton(_ view: FrontpageRetryView) {
        adsRetryView.state = .loading
        delegate?.frontpageViewDidSelectRetryButton(self)
    }
}
