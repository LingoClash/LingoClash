//
//  RevisionSequence.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

/// Note that not all RevisionVocabs need to be tested. They are sorted by a priority queue and only up to a certain
/// day difference they will be tested
///
/// This is just a wrapper around the factory, with a count and when it hits zero it returns null
struct RevisionSequence: QuerySequence {
    
    // Revisions are not generated lazily, so we don't need a constructor for it
//    var constructorFactory: QuestionConstructorRandomFactory
    var questionsLeft: Int?
    
    // Basically you have a priority queue of RevisionQueries
    // and the next function will reduce the number by 1
    // TODO: replace this with a protocol
    var revisionPq: Heap<RevisionQuery>

    init(revisionQueryArr: [RevisionQuery]) {
        // convert into heap
        self.revisionPq = Heap<RevisionQuery>(sort: {
            (rq1: RevisionQuery, rq2: RevisionQuery) -> Bool in
            rq1.magnitude > rq2.magnitude
        })
        self.questionsLeft = revisionQueryArr.count
        
        // initialise pq
        for rq in revisionQueryArr {
            self.revisionPq.insert(rq)
        }
    }
    
    init(deck: Deck) {
        self.init(revisionQueryArr: deck.vocabs)
    }
    
    mutating func insert(_ rq: RevisionQuery) {
        self.revisionPq.insert(rq)
    }
    
    mutating func remove(_ rq: RevisionQuery) {
        self.revisionPq.remove(node: rq)
    }
    
    // pops off from the queue and returns the value
    mutating func next() -> Query? {
        let nextRevision = self.revisionPq.remove()
        self.questionsLeft = revisionPq.count
        
        return nextRevision
    }
}
