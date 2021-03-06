//
//  CCWebViewController.swift
//  clz
//
//  Created by cc on 2021/8/5.
//

import UIKit
import WebKit

open class CCWebViewController: UIViewController {
    open var progressTintColor: UIColor = .blue {
        didSet {
            progressView.progressTintColor = progressTintColor
        }
    }

    open var progressBGColor: UIColor = .white {
        didSet {
            progressView.trackTintColor = progressBGColor
        }
    }

    public init(_ url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let url: URL

    private let progressKeyPath = "estimatedProgress"

    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.tintColor = progressTintColor
        view.trackTintColor = progressBGColor
        return view
    }()

    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .white
        view.scrollView.showsVerticalScrollIndicator = false
        view.scrollView.showsHorizontalScrollIndicator = false
        view.uiDelegate = self
        view.navigationDelegate = self
        return view
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData))
        webView.addObserver(self, forKeyPath: progressKeyPath, options: .new, context: nil)
        configureUI()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if webView.frame.size == .zero {
            var top: CGFloat = 0
            top = view.safeAreaInsets.top
            webView.frame = CGRect(x: 0, y: top, width: view.bounds.width, height: view.bounds.height - top)
            progressView.frame = CGRect(x: 0, y: top, width: view.bounds.width, height: 3)
        }
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == progressKeyPath {
            progressView.alpha = 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1 {
                UIView.animate(withDuration: 0.2) {
                    self.progressView.alpha = 0
                } completion: { _ in
                    self.progressView.setProgress(0, animated: false)
                }
            }
        }
    }
}

// MARK: - configureUI

extension CCWebViewController {
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        view.addSubview(progressView)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - WKUIDelegate,WKNavigationDelegate

extension CCWebViewController: WKUIDelegate, WKNavigationDelegate {
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationItem.title = webView.title
    }
}
