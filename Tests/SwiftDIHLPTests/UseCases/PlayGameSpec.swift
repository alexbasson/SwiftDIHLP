import Quick
import Nimble
import SwiftDIHLP

class PlayGameSpec: QuickSpec {
    override func spec() {

        describe("play") {
            let observer = PlayGameObserverSpy()
            let repo = FakeGameRepository()
            let playGame = PlayGame(observer: observer, repo: repo)

            beforeEach() {
                observer.reset()
            }

            context("when p1 plays rock") {
                let p1 = "rock"

                context("and p2 plays rock") {
                    it("tells the observer that a tie occurred") {
                        playGame.execute(p1: p1, p2: "rock")

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p2 wins") {
                        playGame.execute(p1: p1, p2: "paper")

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p1 wins") {
                        playGame.execute(p1: p1, p2: "scissors")

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }
            }

            context("when p1 plays paper") {
                let p1 = "paper"

                context("and p2 plays rock") {
                    it("tells the observer that p1 wins") {
                        playGame.execute(p1: p1, p2: "rock")

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that a tie occurred") {
                        playGame.execute(p1: p1, p2: "paper")

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that p2 wins") {
                        playGame.execute(p1: p1, p2: "scissors")

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }
            }

            context("when p1 plays scissors") {
                let p1 = "scissors"

                context("and p2 plays rock") {
                    it("tells the observer that p2 wins") {
                        playGame.execute(p1: p1, p2: "rock")

                        expect(observer.p2WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P2Wins))
                    }
                }

                context("and p2 plays paper") {
                    it("tells the observer that p1 wins") {
                        playGame.execute(p1: p1, p2: "paper")

                        expect(observer.p1WinsWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.P1Wins))
                    }
                }

                context("and p2 plays scissors") {
                    it("tells the observer that a tie occurred") {
                        playGame.execute(p1: p1, p2: "scissors")

                        expect(observer.tieWasCalled).to(beTrue())
                        expect(observer.passedInGame!.result).to(equal(GameResult.Tie))
                    }
                }
            }

            context("when p1 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    playGame.execute(p1: "invalid", p2: "rock")

                    expect(observer.invalidGameWasCalled).to(beTrue())
                    expect(observer.passedInGame!.result).to(equal(GameResult.Invalid))
                }
            }

            context("when p2 plays an invalid throw") {
                it("tells the observer that an invalid game occurred") {
                    playGame.execute(p1: "rock", p2: "invalid")

                    expect(observer.invalidGameWasCalled).to(beTrue())
                    expect(observer.passedInGame!.result).to(equal(GameResult.Invalid))
                }
            }
        }
    }
}