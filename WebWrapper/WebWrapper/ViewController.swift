//
//  ViewController.swift
//  WebWrapper
//
//  Created by Orlando G. Rodriguez on 12/1/18.
//  Copyright © 2018 orlandogrodriguez. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class ViewController: UIViewController {
    
    // MARK: - Global Variables
    
    var currentResponse: Int?
    
    // MARK: - Outlets

    var oCurrentResponseLabel: UILabel = {
        let label = UILabel()
        label.text = "No Response"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var oWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var oRequestButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var o200Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("200", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .white
        button.backgroundColor = UIColor(rgb: 0x2ecc71)
        button.layer.cornerRadius = 11
        button.addTarget(self, action: #selector(handle200), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var o404Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("404", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .white
        button.backgroundColor = UIColor(rgb: 0xf39c12)
        button.layer.cornerRadius = 11
        button.addTarget(self, action: #selector(handle404), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var o500Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("500", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .white
        button.backgroundColor = UIColor(rgb: 0xe74c3c)
        button.layer.cornerRadius = 11
        button.addTarget(self, action: #selector(handle500), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForReachability()
        setupUI()
    }

    func setupUI() {
        addCurrentResponseLabel()
        addRequestButtonsStackView()
        addRequestButtons()
        addWebView()
    }
    
    // MARK: - UI Addition Functions
    
    func addCurrentResponseLabel() {
        view.addSubview(oCurrentResponseLabel)
        oCurrentResponseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        oCurrentResponseLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        oCurrentResponseLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30 + 64 + 16).isActive = true
        oCurrentResponseLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func addWebView() {
        view.addSubview(oWebView)
        oWebView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        oWebView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        oWebView.topAnchor.constraint(equalTo: oCurrentResponseLabel.bottomAnchor, constant: 16).isActive = true
        oWebView.bottomAnchor.constraint(equalTo: oRequestButtonStackView.topAnchor, constant: -16).isActive = true
    }
    
    func addRequestButtonsStackView() {
        view.addSubview(oRequestButtonStackView)
        oRequestButtonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        oRequestButtonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        oRequestButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -46).isActive = true
        oRequestButtonStackView.heightAnchor.constraint(equalToConstant: 164).isActive = true
    }
    
    func addRequestButtons() {
        oRequestButtonStackView.addArrangedSubview(o200Button)
        o200Button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        oRequestButtonStackView.addArrangedSubview(o404Button)
        o404Button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        oRequestButtonStackView.addArrangedSubview(o500Button)
        o500Button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func updateModel(status: Int) {
        currentResponse = status
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        if let response = currentResponse {
            oCurrentResponseLabel.text = "Status Code: \(response)"
        } else {
            oCurrentResponseLabel.text = "No Response"
        }
    }
    
    // MARK: - Network
    
    let networkReachabilityManager = Alamofire.NetworkReachabilityManager(host: "https://httpstat.us")
    
    func checkForReachability() {
        networkReachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xe74c3c)
                self.navigationController?.navigationBar.topItem?.title = "No Internet Connection"
            case .reachable(_):
                self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x2ecc71)
                self.navigationController?.navigationBar.topItem?.title = "Connection OK"
            case .unknown:
                print("Unknown")
            }
        }
        networkReachabilityManager?.startListening()
    }
    
    func sendRequest(expectedResponse: Int) {
        if (networkReachabilityManager?.isReachable)! {
            Alamofire.request("https://httpstat.us/\(expectedResponse)")
                .response { response in
                    if let request = response.request {
                        self.oWebView.load(request)
                        self.updateModel(status: response.response!.statusCode)
                    }
            }
            self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x2ecc71)
            self.navigationController?.navigationBar.topItem?.title = "Connection OK"
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xe74c3c)
            self.navigationController?.navigationBar.topItem?.title = "No Internet Connection"
        }
    }
    
    // MARK: - Actions
    
    @objc
    func handle200() {
        sendRequest(expectedResponse: 200)
    }
    
    @objc
    func handle404() {
        sendRequest(expectedResponse: 404)
    }
    
    @objc
    func handle500() {
        sendRequest(expectedResponse: 500)
    }
    
}
