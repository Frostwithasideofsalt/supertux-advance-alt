// If this doesn't get finished then uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh damn
// General
::reloadAzzy <- function() {
    donut("contrib/azzy/script.nut")
}

// Cybergrind
::cybergrindReward <- 0;
::cybergrindWave <- 1;

::cybergrindEnemies <- [[Deathcap, 1, true, 0], [Owl, 2, null, 1]]; // class, wave requirement, args, ground type requirement
::cybergrindAllowedEnemies <- []; // index in cybergrindEnemies
::cybergrindCurrentEnemies <- [];
::cybergrindSpawnSpots <- [[216, 2025, 0], [400, 1905, 1], [400, 1920, 0]]; // x, y, location type (0 is ground, 1 is air, 2 is water)

::cybergrindCalculateWaveReward <- function() {
    cybergrindReward += 30 + (2 * cybergrindWave)
}

::cybergrindStart <- function() {
    cybergrindReward = 0;
    cybergrindWave = 1;
    game.colorswitch[0] = true;
    cybergrindSpawn()
}

::cybergrindSpawn <- function() {
    cybergrindCurrentEnemies.clear()
    local enemies = [];
    foreach (i in cybergrindSpawnSpots) {
        switch (i[2]) {
            case 0:
                cybergrindCurrentEnemies.append(newActor(cybergrindEnemies[0][0], i[0], i[1], cybergrindEnemies[0][2]));
                break;
            case 1:
                break;
            case 2:
                break;
        }
    }
}

::cybergrindProgress <- function() {
    cybergrindCalculateWaveReward()
    cybergrindWave += 1
    cybergrindAllowedEnemies.clear()
    cybergrindSpawn()
}

::cybergrindEnd <- function() {
    game.coins += cybergrindReward
    game.colorswitch[0] = false;
    cybergrindReward = 0;
    cybergrindWave = 1;
}

::cybergrindCheckProgress <- function() {
    local progress = true;
    local text = "WAVE: " + cybergrindWave;
    drawText(font2, (screenW() / 2) - (text.len() * 4), 50, text)
    foreach (i in cybergrindCurrentEnemies) {
        if (checkActor(i)) {
            progress = false;
        }
    }
    if (progress) {
        cybergrindProgress()
    }
}

// Blizzard damage
::blizzardTime <- 0

::damageByBlizzard <- function(modifier = 1) {
    if (blizzardTime > 180) {
        gvPlayer.hurt = 2 * modifier
        blizzardTime = 0
    }
    else {
        blizzardTime++;
    }
}
