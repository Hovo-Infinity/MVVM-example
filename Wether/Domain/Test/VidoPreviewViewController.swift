//
//  VidoPreviewViewController.swift
//  Wether
//
//  Created by Hovhannes Stepanyan on 10/12/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import XCDYouTubeKit
import MediaPlayer

class VidoPreviewViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var creatorLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    private var viewModel: VideoPreviewViewModel!
    private let disposeBag = DisposeBag()

    
    static func viewControllerFor(_ viewModel: VideoPreviewViewModel) -> VidoPreviewViewController {
        let vc = VidoPreviewViewController(nibName: "VidoPreviewViewController", bundle: nil)
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
        // Do any additional setup after loading the view.
    }

    private func bindViews() {
        viewModel.model.bind(onNext: {[weak self] video in
            guard let weakSelf = self else { return }
            weakSelf.imageView.sd_setImage(with: try? video.thumbnailURL.asURL())
            weakSelf.nameLabel.text = video.name
            weakSelf.creatorLabel.text = video.creator.name
        })
        .disposed(by: disposeBag)
    }
    
    @IBAction private func playVideo(_ sender: UIButton) {
        guard let videoId = viewModel.model.value.contentURL.split(separator: "=").last else {
            return
        }
        let videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: String(videoId))
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moviePlayerPlaybackDidFinish(_ :)),
                                               name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish,
                                               object: videoPlayerViewController.moviePlayer)
        self.present(videoPlayerViewController, animated: true)
    }
    
    
    @objc private func moviePlayerPlaybackDidFinish(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish,
                                                  object: notification.object)
        let reason = notification.userInfo?[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
//        if reason == MPMovieFinishReasonPlaybackError {
//            //handle error
//        }
    }
}

extension VidoPreviewViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y > 0 {
            imageView.transform = .identity
        } else {
            let h = imageView.frame.height
            let s = (h - y) / h
            imageView.transform = CGAffineTransform(scaleX: s, y: s)
        }
    }
}
