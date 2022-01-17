//
//  TikTokCell.swift
//  StoreFood
//
//  Created by Kholod Sultan on 14/06/1443 AH.
//

import UIKit
import AVFoundation
protocol VideoCollectionViewCellDelegate: AnyObject
{
  func didTapLikeButton(with model: VideoModel)
  func didTapProfileButton(with model: VideoModel)
  func didTapShareButton(with model: VideoModel)
  func didTapCommentButton(with model: VideoModel)
}
class VideoCollectionViewCell: UICollectionViewCell, UINavigationControllerDelegate {
  static let identifier = "VideoCollectionViewCell"
  private var collectionView: UICollectionView?
//Labels
  private let usernameLabel: UILabel = {
     let label = UILabel ()
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  private let captionLabel: UILabel = {
    let label = UILabel ()
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  private let audioLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .white
    return label
  }()
  // Buttons
  private let profileButton: UIButton = {
     let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "person.circle"), for:.normal)
    button.tintColor = .white
    return button
  }()
  private let likeButton: UIButton = {
     let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "heart.fill"), for:.normal)
    button.tintColor = .white
    return button
  }()
  private let commentButton: UIButton = {
     let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "exclamationmark.bubble"), for:.normal)
    button.tintColor = .white
     return button
  }()
  private let shareButton: UIButton = {
     let button = UIButton()
    button.setBackgroundImage(UIImage(systemName:"arrowshape.turn.up.right.fill"), for:.normal)
    button.tintColor = .white
    return button
  }()
  private let videoContainer = UIView()
  //Delegate
  weak var delegate: VideoCollectionViewCellDelegate?
  // Subviews
  var player: AVPlayer?
    
    var isPlaying = false
    
  private var model: VideoModel?
  override init(frame: CGRect) {
    super.init(frame: frame)
//    contentView.backgroundColor = .red
    contentView.clipsToBounds = true
    addSubviews ()
    }
    private func addSubviews () {
      //Video View
    contentView.addSubview(videoContainer)
      //label Views
    contentView.addSubview(usernameLabel)
    contentView.addSubview(captionLabel)
    contentView.addSubview(audioLabel)
      //Button Views
    contentView.addSubview(profileButton)
    contentView.addSubview(likeButton)
    contentView.addSubview(commentButton)
    contentView.addSubview(shareButton)
      // Add actions
      likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
      profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
      commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
      shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchDown)
      ///////////////////////////////
      ///
//      videoContainer.clipsToBounds = true
      //Video Back
      contentView.sendSubviewToBack(videoContainer)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying = !isPlaying
    }
    
      @objc private func didTapLikeButton() {
      guard let model = model else { return }
      delegate?.didTapLikeButton(with: model)
      }
      @objc private func didTapCommentButton() {
      guard let model = model else { return }
      delegate?.didTapCommentButton(with: model)
      }
  @objc private func didTapShareButton(_ sender: Any) {
          let ShareButton = UIActivityViewController(activityItems: [self.usernameLabel.text], applicationActivities: nil)
    ShareButton.popoverPresentationController?.sourceView = self.videoContainer
//    self.present(ShareButton, AnimationTransition: true, complation: nil)
//          self.present(ShareButton, animated: true, completion: nil)
      guard let model = model else { return }
      delegate?.didTapShareButton(with: model)
         }
      @objc private func didTapProfileButton() {
      guard let model = model else { return }
      delegate?.didTapProfileButton(with: model)
      }
      override func layoutSubviews() {
        super.layoutSubviews()
        videoContainer.frame = videoContainer.bounds
        let size = contentView.frame.size.width/9
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100
        // Buttons
        shareButton.frame = CGRect(x: width-size, y: height-size, width: size, height: size)
//        shareButton.backgroundColor = .red
        commentButton.frame = CGRect(x: width-size, y: height-(size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y: height-(size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width-size, y: height-(size*4)-14, width: size, height: size)
        //labels
        // username. caption, audio
        audioLabel.frame = CGRect (x: 5, y: height-50, width: width-size-10, height: 50)
        captionLabel.frame = CGRect (x: 5, y: height-30, width: width-size-10, height: 50)
        usernameLabel.frame = CGRect(x: 5, y: height-10, width: width-size-10, height: 50)
      }
  override func prepareForReuse() {
    super.prepareForReuse()
    captionLabel.text = nil
    audioLabel.text = nil
    usernameLabel.text = nil
    player?.pause()
  }
    public func configure(with model: VideoModel) {
      contentView.backgroundColor = .white
      self.model = model
    configureVideo()
      //labels
      captionLabel.text = model.caption
      audioLabel.text = model.audioTrackName
      usernameLabel.text = model.username
  }
    
  private func configureVideo() {
  guard let model = model else {
    return
  }
  guard let path = Bundle.main.path(forResource: model.videoFileName,
                     ofType: model.videoFileFormat) else {
                      print("Failed to find video")
                      return
  }
  player = AVPlayer(url: URL(fileURLWithPath: path))
  let playerView = AVPlayerLayer()
  playerView.player = player
  playerView.frame = contentView.bounds
  playerView.videoGravity = .resizeAspectFill
  videoContainer.layer.addSublayer(playerView)
  player?.volume = 50
//  player?.play()
  }
    
    
  required init?(coder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
  }
  }

