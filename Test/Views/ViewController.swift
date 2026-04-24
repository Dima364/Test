//
//  ViewController.swift
//  Test
//
//  Created by Дмитрий Помин on 14.04.2026.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    private let viewModel: AwesomeViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable?
    private let loading = UIActivityIndicatorView(style: .medium)
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("press to min", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.red, for: .normal)
        button.addTarget(
            self,
            action: #selector(buttonTap),
            for: .touchUpInside
        )
        return button
    }()
    
    init(viewModel: AwesomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = true
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.startTimer()
        viewModel.isLoadingPublisher
            .sink { [weak self] isLoading in
                isLoading ? self?.loading.startAnimating() : self?.loading.stopAnimating()
            }
            .store(in: &cancellables)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.stopTimer()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.hidesWhenStopped = true
        
        view.addSubview(button)
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 280),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20)
        ])
        
    }
    
    @objc
    private func buttonTap() {
        viewModel.minElement()
        print(viewModel.minDateItem?.date ?? "no data")
    }
    
    @objc
    private func loadData() {
        viewModel.loadData()
    }
    
}

