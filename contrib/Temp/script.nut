//This acts like how script files work in the mods folder.

//Sprite for custom background
//Remember to change the file directories if you change the contrib world folder name!
::bgTemplateSprite <- newSprite("contrib/Temp/gfx/Template.png", 720, 240, 0, 0, 0, 0)

//Custom background code

::dbgTemplateBackground <- function() {
	for(local i = 0; i < 2; i++) {
		drawSprite(bgTemplateSprite, 0, ((-camx / 8) % 720) + (i * 720), screenH() - 240)
	}
}