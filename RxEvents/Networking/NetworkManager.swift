//
//  NetworkManager.swift
//  RxEvents
//
//  Created by user on 10/24/20.
//

import RxCocoa
import RxSwift

final class NetworkManager {
    // MARK: - Private properties

    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.APIFormatter)
        return decoder
    }()


    // MARK: - Methods

    func request<T: Decodable>(url: String) -> Observable<T> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let url = URL(string: url), let self = self else {
                observer.on(.error(NetworkingError.incorrectURL))
                return Disposables.create()
            }

            return self.urlSession.rx.data(request: URLRequest(url: url))
                .subscribe(onNext: { data in
                    do {
                        let value = try self.decoder.decode(T.self, from: data)
                        observer.on(.next(value))
                    } catch {
                        observer.on(.error(NetworkingError.decodingError))
                    }
                }, onError: { _ in
                    observer.on(.error(NetworkingError.incorrectURL))
                })
        }
    }
}
