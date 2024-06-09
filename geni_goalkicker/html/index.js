resourceName = null;
menuOpen = false;
minigameScore = 10;
minigameCountdown = 0;
currentId = 0;
mySkillMultiplier = 0;
translations = {};
oneTimeDUI = false;
minigameOpen = false;
window.addEventListener('message', function(event) {
    ed = event.data;
    if (ed.action === "openScoreboard") {
        translations = ed.translations;
        resourceName = ed.resourceName;
        menuOpen = true;
        document.getElementById("mainDiv").style.display = "flex";
        // Lang Total Shots
        document.getElementById("totalShotsLang1").innerHTML=translations.totalShots;
        document.getElementById("totalShotsLang2").innerHTML=translations.totalShots;
        document.getElementById("totalShotsLang3").innerHTML=translations.totalShots;
        document.getElementById("totalShotsLang4").innerHTML=translations.totalShots;
        // Lang Shooting Skill
        document.getElementById("shootingSkillLang1").innerHTML=translations.shootingSkill;
        document.getElementById("shootingSkillLang2").innerHTML=translations.shootingSkill;
        document.getElementById("shootingSkillLang3").innerHTML=translations.shootingSkill;
        document.getElementById("shootingSkillLang4").innerHTML=translations.shootingSkill;
        // Lang Highest Score
        document.getElementById("highestScoreLang1").innerHTML=translations.highestScore;
        document.getElementById("highestScoreLang2").innerHTML=translations.highestScore;
        document.getElementById("highestScoreLang3").innerHTML=translations.highestScore;
        document.getElementById("highestScoreLang4").innerHTML=translations.highestScore;
        // Lang Span
        document.getElementById("spanNameLang1").innerHTML=translations.name;
        document.getElementById("spanNameLang2").innerHTML=translations.name;
        document.getElementById("spanNameLang3").innerHTML=translations.name;
        // First
        if (ed.first === undefined) {
            document.getElementById("firstName").innerHTML=translations.defaultName;
            document.getElementById("firstImage").src="files/defaultpp.webp";
            document.getElementById("firstTotalShots").innerHTML=translations.unknown;
            document.getElementById("firstShootingSkill").innerHTML=translations.unknown;
            document.getElementById("firstHighestScore").innerHTML=translations.unknown;
        } else {
            document.getElementById("firstName").innerHTML=ed.first.name;
            document.getElementById("firstImage").src=ed.first.avatar;
            document.getElementById("firstTotalShots").innerHTML=ed.first.total;
            document.getElementById("firstShootingSkill").innerHTML=ed.first.skill;
            document.getElementById("firstHighestScore").innerHTML=ed.first.highest;
        }
        // Second
        if (ed.second === undefined) {
            document.getElementById("secondName").innerHTML=translations.defaultName;
            document.getElementById("secondImage").src="files/defaultpp.webp";
            document.getElementById("secondTotalShots").innerHTML=translations.unknown;
            document.getElementById("secondShootingSkill").innerHTML=translations.unknown;
            document.getElementById("secondHighestScore").innerHTML=translations.unknown;
        } else {
            document.getElementById("secondName").innerHTML=ed.second.name;
            document.getElementById("secondImage").src=ed.second.avatar;
            document.getElementById("secondTotalShots").innerHTML=ed.second.total;
            document.getElementById("secondShootingSkill").innerHTML=ed.second.skill;
            document.getElementById("secondHighestScore").innerHTML=ed.second.highest;
        }
        // Third
        if (ed.third === undefined) {
            document.getElementById("thirdName").innerHTML=translations.defaultName;
            document.getElementById("thirdImage").src="files/defaultpp.webp";
            document.getElementById("thirdTotalShots").innerHTML=translations.unknown;
            document.getElementById("thirdShootingSkill").innerHTML=translations.unknown;
            document.getElementById("thirdHighestScore").innerHTML=translations.unknown;
        } else {
            document.getElementById("thirdName").innerHTML=ed.third.name;
            document.getElementById("thirdImage").src=ed.third.avatar;
            document.getElementById("thirdTotalShots").innerHTML=ed.third.total;
            document.getElementById("thirdShootingSkill").innerHTML=ed.third.skill;
            document.getElementById("thirdHighestScore").innerHTML=ed.third.highest;
        }
        // Mine
        document.getElementById("MDIDTDLeftImage").src=ed.me.avatar;
        document.getElementById("myName").innerHTML=ed.me.name;
        document.getElementById("myRank").innerHTML=translations.myRank + ": " + ed.me.rank;
        document.getElementById("myTotalShots").innerHTML=ed.me.total;
        document.getElementById("myShootingSkills").innerHTML=ed.me.skill;
        document.getElementById("myHighestScore").innerHTML=ed.me.highest;
    } else if (ed.action === "openScoreboardUnknown") {
        translations = ed.translations;
        resourceName = ed.resourceName;
        menuOpen = true;
        document.getElementById("mainDiv").style.display = "flex";
        // Lang Total Shots
        document.getElementById("totalShotsLang1").innerHTML=translations.totalShots;
        document.getElementById("totalShotsLang2").innerHTML=translations.totalShots;
        document.getElementById("totalShotsLang3").innerHTML=translations.totalShots;
        document.getElementById("totalShotsLang4").innerHTML=translations.totalShots;
        // Lang Shooting Skill
        document.getElementById("shootingSkillLang1").innerHTML=translations.shootingSkill;
        document.getElementById("shootingSkillLang2").innerHTML=translations.shootingSkill;
        document.getElementById("shootingSkillLang3").innerHTML=translations.shootingSkill;
        document.getElementById("shootingSkillLang4").innerHTML=translations.shootingSkill;
        // Lang Highest Score
        document.getElementById("highestScoreLang1").innerHTML=translations.shootingSkill;
        document.getElementById("highestScoreLang2").innerHTML=translations.shootingSkill;
        document.getElementById("highestScoreLang3").innerHTML=translations.shootingSkill;
        document.getElementById("highestScoreLang4").innerHTML=translations.shootingSkill;
        // Lang Span
        document.getElementById("spanNameLang1").innerHTML=translations.name;
        document.getElementById("spanNameLang2").innerHTML=translations.name;
        document.getElementById("spanNameLang3").innerHTML=translations.name;
        // First
        document.getElementById("firstName").innerHTML=translations.defaultName;
        document.getElementById("firstImage").src="files/defaultpp.webp";
        document.getElementById("firstTotalShots").innerHTML=translations.unknown;
        document.getElementById("firstShootingSkill").innerHTML=translations.unknown;
        document.getElementById("firstHighestScore").innerHTML=translations.unknown;
        // Second
        document.getElementById("secondName").innerHTML=translations.defaultName;
        document.getElementById("secondImage").src="files/defaultpp.webp";
        document.getElementById("secondTotalShots").innerHTML=translations.unknown;
        document.getElementById("secondShootingSkill").innerHTML=translations.unknown;
        document.getElementById("secondHighestScore").innerHTML=translations.unknown;
        // Third
        document.getElementById("thirdName").innerHTML=translations.defaultName;
        document.getElementById("thirdImage").src="files/defaultpp.webp";
        document.getElementById("thirdTotalShots").innerHTML=translations.unknown;
        document.getElementById("thirdShootingSkill").innerHTML=translations.unknown;
        document.getElementById("thirdHighestScore").innerHTML=translations.unknown;
        // Mine
        document.getElementById("MDIDTDLeftImage").src=ed.me.avatar;
        document.getElementById("myName").innerHTML=ed.me.name;
        document.getElementById("myRank").innerHTML=translations.myRank + ": " + ed.me.rank;
        document.getElementById("myTotalShots").innerHTML=ed.me.total;
        document.getElementById("myShootingSkills").innerHTML=ed.me.skill;
        document.getElementById("myHighestScore").innerHTML=ed.me.highest;
    } else if (ed.action === "opendui") {
        document.getElementById("dui").style.display = "flex";
        let bestSize = 110 / ed.bestText.length;
        document.getElementById("duiBestScore").style.fontSize = bestSize + "vw";
        document.getElementById("duiBestScore").innerHTML=ed.bestText + " " + ed.best;
        if (ed.current) {
            let textSize = 150 / ed.currentText.length;
            document.getElementById("duiYourScore").style.fontSize = textSize + "vw";
            document.getElementById("duiYourScore").innerHTML=ed.currentText + " " + ed.current;
        }
    } else if (ed.action === "yourScore") {
        let text = ed.text;
        let from = 0;
        let to = ed.number;
        let step = to > from ? 1 : -1;
        let interval = 10;
        let counter = this.setInterval(function() {
            from += step;
            document.getElementById("duiYourScore").innerHTML=text + " " + from;
            if (from === to) {
                clearInterval(counter);
            }
        }, interval)
    } else if (ed.action === "openMinigame") {
        mySkillMultiplier = ed.mySkillMultiplier;
        minigameOpen = true;
        // if (mySkillMultiplier > 50) {
        //     mySkillMultiplier = mySkillMultiplier / 1000;
        // } else {
        //     mySkillMultiplier = mySkillMultiplier / 100
        // }
        // console.log(mySkillMultiplier)
        resourceName = ed.resourceName;
        document.getElementById("MinigameDescription").innerHTML=ed.description;
        document.getElementById("pressKeyLang").innerHTML=ed.presskey;
        document.getElementById("MinigameBottomEffect1").style.display = "block";
        document.getElementById("MinigameBottomEffect2").style.display = "block";
        document.getElementById("MinigameBottomEffect3").style.display = "block";
        document.getElementById("minigameDiv").style.display = "flex";
        minigameCountdown = ed.time;
        currentId = ed.id;
        document.getElementById("MDTDH4").innerHTML=minigameCountdown.toString();
        var timer = minigameCountdown, seconds;
        timerInt = setInterval(function() {
            seconds = parseInt(timer % 60, 10);
            seconds = seconds < 10 ? "0" + seconds : seconds;
            document.getElementById("MDTDH4").innerHTML=seconds.toString();
            if (--timer < 0) {
                clearInterval(timerInt);
                var xhr = new XMLHttpRequest();
                xhr.open("POST", `https://${resourceName}/callback`, true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(JSON.stringify({action: "kickedBall", score: Math.round(minigameScore), id: currentId}));
                document.getElementById("minigameDiv").style.display = "none";
                document.getElementById("MDTDH4").innerHTML=minigameCountdown.toString();
                minigameScore = 10;
                document.getElementById("MDPBBallDiv").style.left = minigameScore - 10 + "%";
                document.getElementById("MDProgressBar").style.background = `radial-gradient(14.4% 300% at ${minigameScore - 10}% 50%, #FFF 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.20)`;
                document.getElementById("MinigameBottomEffect1").style.display = "none";
                document.getElementById("MinigameBottomEffect2").style.display = "none";
                document.getElementById("MinigameBottomEffect3").style.display = "none";
                minigameOpen = false;
            }
        }, 1000);
    } else if (ed.action === "updateMinigame") {
        if (minigameScore < 95) {
            minigameScore = minigameScore + mySkillMultiplier;
            document.getElementById("MDPBBallDiv").style.left = minigameScore - 10 + "%";
            document.getElementById("MDProgressBar").style.background = `radial-gradient(14.4% 300% at ${minigameScore - 10}% 50%, #FFF 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.20)`; 
            document.getElementById("MDTDKeyDiv").style.scale = "0.9";
            setTimeout(() => {
                document.getElementById("MDTDKeyDiv").style.scale = "1";
            }, 1000);
        }
    }
    document.onkeyup = function(data){
        if (data.which == 27) {
            if (menuOpen) {
                menuOpen = false;
                document.getElementById("mainDiv").style.display = "none";
                var xhr = new XMLHttpRequest();
                xhr.open("POST", `https://${resourceName}/callback`, true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(JSON.stringify({action: "nuiFocus"}));
            } else if (minigameOpen) {
                clearInterval(timerInt);
                minigameScore = 10;
                document.getElementById("minigameDiv").style.display = "none";
                document.getElementById("MDPBBallDiv").style.left = minigameScore - 10 + "%";
                document.getElementById("MDProgressBar").style.background = `radial-gradient(14.4% 300% at ${minigameScore - 10}% 50%, #FFF 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.20)`;
                document.getElementById("MinigameBottomEffect1").style.display = "none";
                document.getElementById("MinigameBottomEffect2").style.display = "none";
                document.getElementById("MinigameBottomEffect3").style.display = "none";
                minigameOpen = false;
                var xhr = new XMLHttpRequest();
                xhr.open("POST", `https://${resourceName}/callback`, true);
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(JSON.stringify({action: "cancelKick", id: currentId}));
            }
        }
        if (data.which == 69 && minigameOpen) {
            if (minigameScore < 95) {
                minigameScore = minigameScore + mySkillMultiplier;
                document.getElementById("MDPBBallDiv").style.left = minigameScore - 10 + "%";
                document.getElementById("MDProgressBar").style.background = `radial-gradient(14.4% 300% at ${minigameScore - 10}% 50%, #FFF 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.20)`; 
                document.getElementById("MDTDKeyDiv").style.scale = "0.9";
                setTimeout(() => {
                    document.getElementById("MDTDKeyDiv").style.scale = "1";
                }, 1000);
            }
        }
    }
})

function clFunc(name1) {
    if (name1 === "closeMenu") {
        menuOpen = false;
        document.getElementById("mainDiv").style.display = "none";
        var xhr = new XMLHttpRequest();
        xhr.open("POST", `https://${resourceName}/callback`, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(JSON.stringify({action: "nuiFocus"}));
    }
}