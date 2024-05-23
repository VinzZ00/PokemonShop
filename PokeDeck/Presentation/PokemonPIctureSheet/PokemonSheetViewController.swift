//
//  PokemonPictureSheetViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import UIKit

protocol PokemonSheetViewControllerDelegate: AnyObject {
    func didDismissModalViewController()
}


class PokemonSheetViewController: UIViewController {
    
    weak var delegate: PokemonSheetViewControllerDelegate?
    
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var imageView : UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    var url : String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel : PokemonSheetViewModel = PokemonSheetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        
        // Do any additional setup after loading the view.
        
        viewModel.image
            .receive(on: DispatchQueue.main)
            .sink { img in
                self.imageView.image = img
            }.store(in: &viewModel.cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchImage(url: self.url)
    }
    
    @objc func handlePanGesture(_ sender : UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view?.window)
        
        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y - initialTouchPoint.y > 0 {
                view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: view.frame.size.width, height: view.frame.size.height)
            }
        case .ended, .cancelled:
            if touchPoint.y - initialTouchPoint.y > 100 {
                delegate?.didDismissModalViewController()
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        default:
            break
        }
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
