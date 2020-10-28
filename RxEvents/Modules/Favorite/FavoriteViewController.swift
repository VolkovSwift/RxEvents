//
//  FavoriteViewController.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit
import RxSwift
import RxCocoa

final class FavoriteViewController: UIViewController {

    typealias Factory = ViewControllerFactory & ViewModelFactory
    
    //MARK: - Private Properties
    
    private let tableView = UITableView()

    private let disposeBag = DisposeBag()
    private let factory: Factory
    
    private lazy var viewModel = factory.makeFavoriteViewModel()
    
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
        viewModel.refresh()
    }
    
    //MARK: - Private Methods
    
    private func configureUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        tableView.register(EventsCell.self, forCellReuseIdentifier: EventsCell.reuseID)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func bind() {
        viewModel.objects.bind(to: tableView.rx.items(cellIdentifier: EventsCell.reuseID, cellType: EventsCell.self)) {_, object, cell in
            cell.configure(object: object, delegate: self)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(EventObject.self)
            .subscribe(onNext: { self.presentSafariVC(with: $0.event.url)})
            .disposed(by: disposeBag)
    }
}

//MARK: - CellActionsDelegate

extension FavoriteViewController: CellActionsDelegate {
    func favoriteButtonWasPressed(event: EventItem) {
        viewModel.toggle(event: event)
    }
}
