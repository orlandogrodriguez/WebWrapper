//
//  ViewController.swift
//  WebWrapper
//
//  Created by Orlando G. Rodriguez on 12/1/18.
//  Copyright © 2018 orlandogrodriguez. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var currentResponse: Int?

    var oCurrentResponseLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Response: "
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
        oCurrentResponseLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46).isActive = true
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
    
    // MARK: - Actions
    
    @objc
    func handle200() {
        print("Pressed 200")
    }
    
    @objc
    func handle404() {
        print("Pressed 404")
    }
    
    @objc
    func handle500() {
        print("Pressed 500")
    }
    
}
