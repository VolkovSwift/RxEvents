//
//  EventsViewController.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit
import RxSwift
import RxCocoa

protocol CellActionsDelegate: AnyObject {
    func favoriteButtonWasPressed(event: EventItem)
}

final class EventsViewController: UIViewController {

    typealias Factory = ViewControllerFactory & ViewModelFactory
    
    //MARK: - Private Properties
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()
    
    private let disposeBag = DisposeBag()
    private let factory: Factory
    
    private lazy var viewModel = factory.makeEventsViewModel()
    
    //MARK: - Lifecycle
    
    init(factory: Factory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.layoutIfNeeded()
    }
    
    //MARK: - Private Methods
    
    private func configureUI() {
        tableView.refreshControl = refreshControl
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        tableView.register(EventsCell.self, forCellReuseIdentifier: EventsCell.reuseID)
        tableView.tableFooterView = UIView(frame: .zero)
        
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    private func bind() {
        refreshControl.rx
            .controlEvent(.valueChanged)
            .bind(to: viewModel.refreshObjects)
            .disposed(by: disposeBag)
        
        viewModel.objects.bind(to: tableView.rx.items(cellIdentifier: EventsCell.reuseID, cellType: EventsCell.self)) {_, object, cell in
            cell.configure(object: object, delegate: self)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(EventObject.self)
            .subscribe(onNext: { self.presentSafariVC(with: $0.event.url)})
            .disposed(by: disposeBag)

        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                self.presentAlert(title: error)
            })
            .disposed(by: disposeBag)
        
        viewModel.loading
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loading.skip(1)
            .observeOn(MainScheduler.instance)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}

//MARK: - CellActionsDelegate

extension EventsViewController: CellActionsDelegate {
    func favoriteButtonWasPressed(event: EventItem) {
        viewModel.toggle(event: event)
    }
}
