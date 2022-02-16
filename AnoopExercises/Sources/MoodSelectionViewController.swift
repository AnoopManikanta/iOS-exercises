//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addMoodButton: UIButton!
    @IBOutlet var moodsTableView: UITableView!
    @IBOutlet var moodSelector: ImageSelector!
    var containerView: UIView!
    var moodsViewController: MoodListViewController!
    
    // set images, highlight color and current mood
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodSelector.images = moods.map{$0.image}
            moodSelector.highlightColors = moods.map{ $0.color }
        }
    }
    
    // change button title on mood selection
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton.setTitle(nil, for: .normal)
                addMoodButton.backgroundColor = nil
                return
            }
            addMoodButton.setTitle("I'm \(currentMood.name)", for: .normal)
            
            // animation for add button
            let selectionAnimator = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.7) {
                self.addMoodButton.backgroundColor = currentMood.color
            }
            selectionAnimator.startAnimation()
        }
    }

    // add current mood to table on button tap
    @objc func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood else {
            return
        }
        let newMood = MoodEntry(mood: currentMood, timestamp: Date())
        moodsViewController.add(newMood)
        moodsTableView.reloadData()
    }
    
    // change current mood based on the image selected from the bottom bar
    @objc func moodSelectionChanged(_ sender: ImageSelector) {
        let selectedIndex = sender.selectedIndex
        currentMood = moods[selectedIndex]
        print(currentMood!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        moodSelector = ImageSelector()
        moodSelector.translatesAutoresizingMaskIntoConstraints = false
        moodSelector.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .valueChanged)
        let blurView = blurEffectView()
        stackView = horizontalStackView()
        addMoodButton = button()
        addMoodButton.addTarget(self, action: #selector(addMoodTapped(_:)), for: .touchUpInside)
        
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        containerView = UIView()
        containerView.frame = view.frame
        
        moodsViewController = MoodListViewController()
        moodsTableView = tableView()
        moodsTableView.frame = containerView.frame
        moodsTableView.delegate = moodsViewController
        moodsTableView.dataSource = moodsViewController
        moodsTableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 130,right: 0)
        
        blurView.contentView.addSubview(moodSelector)
        view.addSubview(blurView)
        view.addSubview(addMoodButton)
        view.addSubview(containerView)
        view.sendSubviewToBack(containerView)
        containerView.addSubview(moodsTableView)
        
        NSLayoutConstraint.activate([
            blurView.contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            blurView.contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            blurView.contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            moodSelector.topAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: 8),
            moodSelector.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor, constant: -30),
            moodSelector.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moodSelector.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            moodSelector.heightAnchor.constraint(equalToConstant: 50),
            addMoodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addMoodButton.heightAnchor.constraint(equalToConstant: 45),
            addMoodButton.bottomAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: -20),
            addMoodButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: 0),
        ])
        containerView.didMoveToSuperview()
    }
    
    private func button() -> UIButton {
        let button = UIButton()
        button.setTitle("Add Mood", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func horizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }
    
    private func blurEffectView() -> UIVisualEffectView{
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }
    
    private func tableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(TableCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 65
        return tableView
    }
}

