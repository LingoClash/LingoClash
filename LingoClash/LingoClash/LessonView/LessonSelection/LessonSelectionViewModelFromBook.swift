//
//  LessonSelectionViewModelFromBook.swift
//  LingoClash
//
//  Created by Sherwin Poh on 23/3/22.
//

class LessonSelectionViewModelFromBook: LessonSelectionViewModel {
    let starsTotalPerLevel = 3
    private var book: Book
    var lessonTableViewModels: Dynamic<[LessonTableCellViewModel]> = Dynamic([])
    var lessonOverviewViewModel: Dynamic<LessonOverviewViewModel?> = Dynamic(nil)
    var starsObtained: Dynamic<String> = Dynamic("")
    var lessonsPassed: Dynamic<String> = Dynamic("")

    init(book: Book) {
        self.book = book
        reloadLessons()
    }

    func didSelectLesson(at index: Int) {
        var selectedLesson = book.lessons[index]
        selectedLesson.vocabs.append(Vocab(word: "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", definition: "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", sentence: "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", sentenceDefinition: "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd", pronunciationText: "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"))
        self.lessonOverviewViewModel.value = LessonOverviewViewModelFromLesson(lesson: selectedLesson)
    }

    func reloadLessons() {
        // TODO: TO replace with actual data fetching
        self.lessonTableViewModels.value = book.lessons.map { LessonTableCellViewModelFromLesson(lesson: $0) }
        updateStarsObtained()
        updateLevelsPassed()
    }

    private func updateStarsObtained() {
        let starsObtained = book.lessons.reduce(0, { $0 + $1.stars })
        let starsTotal = book.lessons.count * starsTotalPerLevel
        self.starsObtained.value = String(starsObtained) + "/" + String(starsTotal)
    }

    private func updateLevelsPassed() {
        let levelsPassed = book.lessons.filter { $0.didPass }.count
        let levelTotal = book.lessons.count
        self.lessonsPassed.value = String(levelsPassed) + "/" + String(levelTotal)
    }
}
