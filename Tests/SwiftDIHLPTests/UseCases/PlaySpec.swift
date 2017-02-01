import Quick
import Nimble
import SwiftDIHLP

class ObserverSpy: GameObserver {
    var p1WinsWasCalled = false
    var p2WinsWasCalled = false
    var tieWasCalled = false
    var invalidGameWasCalled = false

    func p1Wins() {
        p1WinsWasCalled = true
    }

    func tie() {
        tieWasCalled = true
    }

    func p2Wins() {
        p2WinsWasCalled = true
    }

    func invalidGame() {
        invalidGameWasCalled = true
    }

    func reset() {
        p1WinsWasCalled = false
        p2WinsWasCalled = false
        tieWasCalled = false
        invalidGameWasCalled = false
    }
}

class PlaySpec: QuickSpec {
    override func spec() {

        describe("play") {
            let observer = ObserverSpy()

            beforeEach() {
                observer.reset()
            }

            context("when p1 plays rock") {
                let p1 = "rock"

                context("and p2 plays rock") {
                    it("tells the observer that a tie occurred") {
                        let play = PlayUseCase(p1: p1, p2: "rock", observer: observer)
                        play.execute()
                        expect(observer.tieWasCalled).to(beTrue())
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p2 wins") {
                        let play = PlayUseCase(p1: p1, p2: "paper", observer: observer)
                        play.execute()
                        expect(observer.p2WinsWasCalled).to(beTrue())
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p1 wins") {
                        let play = PlayUseCase(p1: p1, p2: "scissors", observer: observer)
                        play.execute()
                        expect(observer.p1WinsWasCalled).to(beTrue())
                    }
                }
            }

            context("when p1 plays paper") {
                let p1 = "paper"

                context("and p2 plays rock") {
                    it("tells the observer that p1 wins") {
                        let play = PlayUseCase(p1: p1, p2: "rock", observer: observer)
                        play.execute()
                        expect(observer.p1WinsWasCalled).to(beTrue())
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that a tie occurred") {
                        let play = PlayUseCase(p1: p1, p2: "paper", observer: observer)
                        play.execute()
                        expect(observer.tieWasCalled).to(beTrue())
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p2 wins") {
                        let play = PlayUseCase(p1: p1, p2: "scissors", observer: observer)
                        play.execute()
                        expect(observer.p2WinsWasCalled).to(beTrue())
                    }
                }
            }

            context("when p1 plays scissors") {
                let p1 = "scissors"

                context("and p2 plays rock") {
                    it("tells the observer that p2 wins") {
                        let play = PlayUseCase(p1: p1, p2: "rock", observer: observer)
                        play.execute()
                        expect(observer.p2WinsWasCalled).to(beTrue())
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p1 wins") {
                        let play = PlayUseCase(p1: p1, p2: "paper", observer: observer)
                        play.execute()
                        expect(observer.p1WinsWasCalled).to(beTrue())
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that a tie occurred") {
                        let play = PlayUseCase(p1: p1, p2: "scissors", observer: observer)
                        play.execute()
                        expect(observer.tieWasCalled).to(beTrue())
                    }
                }
            }

            context("when p1 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    let play = PlayUseCase(p1: "invalid", p2: "rock", observer: observer)
                    play.execute()
                    expect(observer.invalidGameWasCalled).to(beTrue())
                }
            }

            context("when p2 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    let play = PlayUseCase(p1: "rock", p2: "invalid", observer: observer)
                    play.execute()
                    expect(observer.invalidGameWasCalled).to(beTrue())
                }
            }
        }
    }
}
