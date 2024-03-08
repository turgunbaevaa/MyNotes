//
//  OnBoardingView.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 7/3/24.
//

import UIKit
import SnapKit

class OnBoardingView: UIViewController {
    
    private var onBoard: [OnBoard] = [
        OnBoard(image: "first_img", title: "Welcome to The Note", descTitle: "Welcome to The Note – your new companion for tasks, goals, health – all in one place. Let's get started!"),
        OnBoard(image: "second_img", title: "Set Up Your Profile", descTitle: "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals."),
        OnBoard(image: "third_img", title: "Dive into The Note", descTitle: "You're fully equipped to dive into the world of The Note. Remember, we're here to assist you every step of the way. Ready to start? Let's go!")]
    
    private lazy var onBoardingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardCell.self, forCellWithReuseIdentifier: OnBoardCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    var currentPage = 0
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .darkGray
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 21
        view.backgroundColor = UIColor().rgb(r: 255, g: 61, b: 61, alpha: 1)
        return view
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(.red, for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnBoardingCollectionView()
        setupPageControl()
        setupSkipButton()
        setupNextButton()
    }
    
    private func setupOnBoardingCollectionView(){
        view.addSubview(onBoardingCollectionView)
        onBoardingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(0)
            make.horizontalEdges.equalToSuperview().inset(0)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func setupPageControl(){
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func setupSkipButton(){
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-133)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(173)
            make.height.equalTo(42)
        }
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }
    
    private func setupNextButton(){
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-133)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(skipButton.snp.centerY)
            make.width.equalTo(173)
            make.height.equalTo(42)
        }
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func skipButtonTapped(){
        navigationController?.pushViewController(HomeView(), animated: true)
        UserDefaults.standard.set(true, forKey: "isOnboardingSkipped")
    }
    
    @objc func nextButtonTapped(){
        if currentPage == 2 {
            navigationController?.pushViewController(HomeView(), animated: true)
        } else {
            onBoardingCollectionView.isPagingEnabled = false
            onBoardingCollectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
            onBoardingCollectionView.isPagingEnabled = true
        }
    }
}

extension OnBoardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardCell.reuseId, for: indexPath) as! OnBoardCell
        cell.setData(onBoard[indexPath.row].image, title: onBoard[indexPath.row].title, descTitle: onBoard[indexPath.row].descTitle)
        return cell
    }
}

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.x
        let page = (contentOffset / view.frame.width)
        
        switch page {
        case 0.0:
            currentPage = 0
            pageControl.currentPage = 0
            print("Первая страница")
        case 1.0:
            currentPage = 1
            pageControl.currentPage = 1
            print("Вторая страница")
        case 2.0:
            UserDefaults.standard.set(true, forKey: "isOnBoardShown")
            currentPage = 2
            pageControl.currentPage = 2
            print("Третья страница")
        default:
            ()
        }
    }
}
