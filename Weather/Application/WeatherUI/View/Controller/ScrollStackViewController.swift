//
//  ScrollStackViewController.swift
//  Weather
//
//  Created by Ndamu Nengovhela on 2023/10/24.
//

import UIKit

class ScrollStackViewController: UIViewController {

    weak var backgroundColor: UIColor? {
        WeatherAsset.Color.sunny.color
    }

    lazy var mainStack = UIStackView().configureStackView {
        $0.axis = .vertical
        $0.isLayoutMarginsRelativeArrangement = true
    }

    lazy var scrollView = UIScrollView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = view.backgroundColor
    }

    func configureViews() {
        view.backgroundColor = backgroundColor
        scrollView.keyboardDismissMode = .onDrag
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
    }

    func layoutViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        scrollView.constrainEdges(.all, ofView: view)
        mainStack.constrainEdges(.all, ofView: scrollView)
        mainStack.constrainToWidth(of: scrollView.widthAnchor)
    }

}

extension ScrollStackViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        mainStack.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove(_ child: UIViewController) {
        guard child.parent != nil else {
            return
        }

        child.willMove(toParent: nil)
        mainStack.removeArrangedSubview(child.view)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
