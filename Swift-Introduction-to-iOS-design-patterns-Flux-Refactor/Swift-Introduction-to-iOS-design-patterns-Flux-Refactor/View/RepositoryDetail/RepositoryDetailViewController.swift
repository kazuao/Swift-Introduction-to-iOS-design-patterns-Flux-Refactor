//
//  RepositoryDetailViewController.swift
//  Swift-Introduction-to-iOS-design-patterns-Flux-Refactor
//
//  Created by kazunori.aoki on 2021/10/13.
//

import UIKit
import GitHub
import WebKit
import RxSwift
import RxCocoa

class RepositoryDetailViewController: UIViewController {
    
    // MARK: UI
    @IBOutlet weak var prograssView: UIProgressView!
    @IBOutlet weak var webviewContainer: UIView! {
        didSet {
            webview.translatesAutoresizingMaskIntoConstraints = false
            webviewContainer.addSubview(webview)
            
            let constraints = [.top, .right, .left, .bottom].map {
                NSLayoutConstraint(item: webviewContainer!,
                                   attribute: $0,
                                   relatedBy: .equal,
                                   toItem: webview,
                                   attribute: $0,
                                   multiplier: 1,
                                   constant: 0)
            }
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    
    // MARK: Variable
    private let configuration = WKWebViewConfiguration()
    private lazy var webview = WKWebView(frame: .zero, configuration: configuration)
    
    private lazy var favoriteButton = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    
    private let flux: Flux
    private lazy var viewModel
        = RepositoryDetailViewModel(estimatedProgress: webview.rx.observeWeakly(Double.self,
                                                                                #keyPath(WKWebView.estimatedProgress)),
                                    favoriteButtonTap: favoriteButton.rx.tap.asObservable(),
                                    flux: flux)
    private let disposeBag = DisposeBag()
    
    
    // MARK: Initialize
    init(flux: Flux = .shared) {
        self.flux = flux
        
        super.init(nibName: "RepositoryDetailViewController", bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = favoriteButton
        
        setupBind()
    }
}


// MARK: - Setup
private extension RepositoryDetailViewController {
    func setupBind() {
        viewModel.estimatedProgress
            .bind(to: Binder(self) { _self, progress in
                UIView.animate(withDuration: 0.3) {
                    let isShown = 0.0..<1.0 ~= progress
                    _self.prograssView.alpha = isShown ? 1 : 0
                    _self.prograssView.setProgress(Float(progress), animated: isShown)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.favoriteButtonTitle
            .bind(to: Binder(favoriteButton) { button, title in
                button.title = title
            })
            .disposed(by: disposeBag)
        
        viewModel.repository
            .bind(to: Binder(webview) { webView, repository in
                webView.load(URLRequest(url: repository.htmlURL))
            })
            .disposed(by: disposeBag)
    }
}

