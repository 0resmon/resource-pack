local Translations = {
    ui = {
       totalShots = "Total Shots",
       shootingSkill = "Shooting Skill",
       highestScore = "Highest Score",
       myRank = "My Rank",
       defaultName = "Name Lastname",
       unknown = "Unknown",
       name = "Name",
       minigameDescription = "Tap for %{time} seconds, score rises with each press. Achieve highest score by tapping rapidly within the time limit.",
       minigamePressKey = "Press Key"
    },
    target = {
        kickBall = "Kick Ball",
        showScoreboard = "Show Scoreboard"
    },
    text3d = {
        text = "[E] Kick Ball | [K] Show Scoreboard"
    },
    dui = {
        bestScore = "Best:",
        yourScore = "Your Score:"
    }
}
Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})