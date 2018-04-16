//
//  VideoSplashViewController.swift
//  VideoSplash
//
// 
//
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode {
  case aspectFill
  case aspectFit
  case fill
  case none
}

open class VideoSplashViewController: UIViewController {

    var moviePlayer :MPMoviePlayerController? = MPMoviePlayerController()
  open var contentURL: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "mp4")!) {
    didSet {
      setMoviePlayer(contentURL)
    }
  }

  open var videoFrame: CGRect = CGRect()
  open var startTime: CGFloat = 0.0
  open var duration: CGFloat = 0.0
  open var backgroundColor: UIColor = UIColor.black {
    didSet {
      view.backgroundColor = backgroundColor
    }
  }
  open var alpha: CGFloat = CGFloat() {
    didSet {
      moviePlayer!.view.alpha = alpha
    }
  }
  open var alwaysRepeat: Bool = true {
    didSet {
      if alwaysRepeat {
        moviePlayer!.repeatMode = MPMovieRepeatMode.one
      }else{
        moviePlayer!.repeatMode = MPMovieRepeatMode.none
      }
    }
  }
  open var fillMode: ScalingMode = .aspectFill {
    didSet {
      switch fillMode {
      case .aspectFill:
        moviePlayer!.scalingMode = MPMovieScalingMode.aspectFill
      case .aspectFit:
        moviePlayer!.scalingMode = MPMovieScalingMode.aspectFit
      case .fill:
        moviePlayer!.scalingMode = MPMovieScalingMode.fill
      case .none:
        moviePlayer!.scalingMode = MPMovieScalingMode.none
      }
    }
  }

  override open func viewDidAppear(_ animated: Bool) {
    moviePlayer!.view.frame = videoFrame
    moviePlayer!.controlStyle = MPMovieControlStyle.none
    moviePlayer!.movieSourceType = MPMovieSourceType.file
    view.addSubview(moviePlayer!.view)
    view.sendSubview(toBack: moviePlayer!.view)
  }

  fileprivate func setMoviePlayer(_ url: URL){
    let videoCutter = VideoCutter()
    videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
      if let path = videoPath as URL? {
        let qos = DispatchQoS.QoSClass.default
        DispatchQueue.global(qos: qos).async {
          DispatchQueue.main.async {
            self.moviePlayer!.contentURL = path
            self.moviePlayer!.play()
          }
        }
      }
    }
  }

  override open func viewDidLoad() {
    super.viewDidLoad()
  }

  override open func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
