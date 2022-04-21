//
//  ProfileViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 13/3/22.
//

import UIKit
import Combine
import FirebaseAuth
import FSCalendar

class ProfileViewController: UIViewController {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var totalStarsLabel: UILabel!
    @IBOutlet private var starsTodayLabel: UILabel!
    @IBOutlet private var starsGoalLabel: UILabel!
    @IBOutlet private var bioLabel: UILabel!
    @IBOutlet private var vocabsLearntLabel: UILabel!
    @IBOutlet private var pkWinningRateLabel: UILabel!
    @IBOutlet private var rankingByTotalStarsLabel: UILabel!
    @IBOutlet private var starsGoalProgressView: UIProgressView!
    @IBOutlet private var starsGoalIcon: UIImageView!
    @IBOutlet private var calendar: FSCalendar!
        
    private let viewModel = ProfileViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    private let gregorian = Calendar(identifier: .gregorian)
    private var dateToStars: [Date: Int] = [:]
    
    override func loadView() {
        super.loadView()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "CalendarCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.refresh()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopRefresh()
    }
    
    func setUpBinderForLabel(label: UILabel, publisher: Published<String?>.Publisher) {
        publisher.sink { value in
            if let value = value {
                label.text = value
            }
        }.store(in: &cancellables)
    }
    
    func setUpBinders() {
        let bindings: [UILabel: Published<String?>.Publisher] = [
            self.nameLabel: viewModel.$name,
            self.totalStarsLabel: viewModel.$totalStars,
            self.starsTodayLabel: viewModel.$starsToday,
            self.starsGoalLabel: viewModel.$starsGoal,
            self.rankingByTotalStarsLabel: viewModel.$rankingByTotalStars,
            self.vocabsLearntLabel: viewModel.$vocabsLearnt,
            self.pkWinningRateLabel: viewModel.$pkWinningRate,
            self.bioLabel: viewModel.$bio
        ]
        
        for (label, publisher) in bindings {
            setUpBinderForLabel(label: label, publisher: publisher)
        }
        
        viewModel.$starsGoalProgress.sink {[weak self] starsGoalProgress in
            if let starsGoalProgress = starsGoalProgress {
                self?.starsGoalProgressView.progress = starsGoalProgress
                self?.starsGoalIcon.alpha = max(CGFloat(starsGoalProgress), 0.5)
            }
        }.store(in: &cancellables)
        
        viewModel.$bio.sink {[weak self] bio in
            if let bio = bio {
                self?.bioLabel.text = "\"\(bio)\""
            }
        }.store(in: &cancellables)
        
        viewModel.$isRefreshing.sink {[weak self] isRefreshing in
            if isRefreshing {
                self?.showSpinner()
            } else {
                self?.removeSpinner()
            }
        }.store(in: &cancellables)
        
        viewModel.$dateToStars.sink {[weak self] dateToStars in
            self?.dateToStars = dateToStars
            self?.calendar.reloadData()
        }.store(in: &cancellables)
    }
}

extension ProfileViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CalendarCell", for: date, at: position)
        guard let calendarCell = cell as? CalendarCell else {
            return cell
        }
        return calendarCell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let startDay = Calendar.current.startOfDay(for: date)
        if let stars = dateToStars[startDay] {
            return min(stars, 3)
        }
        return 0
    }
}
