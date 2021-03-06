# MKS22X-FinalProject

## Description
Plants vs. Zombies is tower defense game takes place in the player’s front lawn, where the player must defend their home against waves of zombies. The player uses seed packets to plant a variety of plants that either attack or defend them from zombies. The player can purchase plants from an inventory bar at the top of the screen according to how many suns they collect throughout the game. Sun is grown by the sunflower plant, but it is also generated randomly throughout the game. Zombies walk slowly towards the house and must be shot down before they reach the plants, or else they will destroy the plants and eventually break into the player’s home. The game ends when zombies enter the house and eat the player's brains.

## Instructions
<ul>
   <li> Navigate through the Main Menu and in-game menu by clicking on the different options. You may refer to the description and instructions of the game through the menu or quit at any point in the game. </li>
   <li> At the start of the game, you are given 300 suns. Use them to plant a Peashooter, Sunflower, Walnut, or Cherry Bomb by clicking the appropriate seed packet and dropping the plant onto a plot of land. NOTE: You may only purchase a plant if you have enough Suns for it. </li>
   <li> Collect Suns that drop from the sky or Sunflower plants by clicking on them. Keep track of the number of Suns by looking at the sun counter on the top left corner of the screen. </li>
   <li> Defend your lawn by using your plants strategically against the zombies. Peashooter can shoot a pea every second, Sunflower produces a Sun every few seconds, Walnut blocks zombies from moving forward until it is eaten, and Cherry Bomb self-destructs, killing nearby zombies in its vicinity. </li>
   <li> The lawn mowers are a final line of defense that automatically trigger after zombies have reached the end of the lawn. Plan wisely – they can only be used once! </li>
   <li> Every time a wave is announced, more zombies will appear within a short period of time. Prepare your attack and defense accordingly, especially for the final wave in the level. </li>
   <li> If you defeat all the zombies in a given level, you may move on to the next level. If the zombies break into your home and eat your brains, the game is over. </li>
</ul>

## Development Log

### 2019-06-04
#### Sabrina
<ul>
  <li> Added cherry bomb plant and seed features for player use. </li>
  <li> Coded zombie and cherry bomb collision into the Zombie class. </li>
</ul>

#### Jamie
<ul>
  <li> Added the main menu and in-game menu display and button options for player access. </li>
  <li> Coded separate act() method to add functionality to the start game, resume game, instructions, main menu, menu, and quit buttons. </li>
  <li> Added page flip option to the instructions display for easier player viewing. </li>
  <li> Started reset game function for the in-game menu. </li>
</ul>

### 2019-06-03

#### Sabrina
<ul>
  <li> Added theme song to play during the game. </li>
  <li> Added sound effect for dying zombies. </li>
</ul>

### 2019-06-02

#### Jamie
<ul>
   <li> Experimented with Character animations using rotations and frame counts to move Zombies and Plants. </li>
   <li> Added randomly generated suns (not from Sunflower) every few seconds and sun rotations. </li>
   <li> Included separate movement for sun once clicked, so that the sun moves parabolically towards the sun counter before disappearing. </li>
   <li> Added zoom-in feature to GameStrings. </li>
</ul>

### 2019-05-31

#### Pair Work
<ul>
   <li> Created Positions class to optimize zombie generation based on the number of plants in each lane. </li>
   <li> Added probability variable to distribute zombies more evenly among the different lanes. </li>
</ul>

#### Sabrina
<ul>
   <li> Updated probability for the lanes and added a cap to the number of active zombies at once. </li>
   <li> Fixed code for the final wave so the zombies now come together. </li>
</ul>

### 2019-05-30

#### Sabrina
<ul>
   <li> Coded final wave for zombies after a certain amount of time into the game. </li>
   <li> Worked on syncing zombie entrance based on the frameCount. </li>
</ul>

#### Jamie
<ul>
   <li> Updated end game screen by adding a switch to stop the displaying/movement of characters, peas, and suns if "GAME OVER" screen is reached. </li>
   <li> Added switches for LawnMower activation and movement to resolve inconsistent killing of zombies. </li>
   <li> Started Menu class to switch between screens based on the number key pressed. </li>
</ul>

### 2019-05-29

#### Sabrina
<ul>
   <li> Added "GAME OVER" message to the screen once zombies reach the house. </li>
</ul>

#### Jamie
<ul>
   <li> Coded LawnMower attack method and collideable code to trigger if zombies have passed the plants and are within 100 units from the house. </li>
   <li> Fixed the Walnut seed packet and planting, and fixed the drag image display for Walnuts, Peashooters, and Sunflowers based on drag and plant counts. </li>
   <li> Updated plant and plant seed images and sizing for easier colliding and clicking recognition. </li>
</ul>

### 2019-05-28

#### Pair work
<ul>
   <li> Completed GameString class to change size, location, and centering of the text. </li>
   <li> Resolved conflicting coordinate specifications and spacing between Master and test branches. </li>
</ul>

#### Sabrina
<ul>
   <li> Created a Walnut class as a defense child of the Plant class. </li>
   <li> Added seed packet to plant Walnut during the game. </li>
</ul>

#### Jamie
<ul>
   <li> Created LawnMower class, which triggers when zombies reach a certain distance from the house. </li>
</ul>

### 2019-05-26

#### Sabrina
<ul>
  <li> Continued code to get rid of the "Need more suns" message based on time or frame count. </li>
</ul>

### 2019-05-24

#### Sabrina
<ul>
   <li> Added text message for when the player does not have enough suns. </li>
   <li> Started code to get rid of the text from the game screen after several seconds. </li>
</ul>

### 2019-05-23

#### Pair work
<ul>
   <li> Fixed the plant dragging image based on the coordinates that the mouse first clicked on. </li>
   <li> Added randomly generated zombies on the right side of the screen. </li>
   <li> Added tracking feature of plots to ensure that no two living plants are on the same plot of land. </li>
</ul>

#### Sabrina
<ul>
   <li> Started coding to tint the seed cards when they are not available for purchase. </li>
</ul>

#### Jamie
<ul>
   <li> Fixed bug in the plots tracking so that different plants (Peashooter and Sunflower) no longer overlap on the same plot of land. </li>
</ul>

### 2019-05-22

#### Pair work
<ul>
   <li> Worked on Peashooter and Sunflower seed packets to plant a new Plant at the specified plot of land. </li>
   <li> Fixed bug in sun counter so that text updates properly when a sun is collected. </li>
   <li> Created a Character parent class for common methods shared between Plant and Zombie classes. </li>
</ul>

#### Sabrina
<ul>
   <li> Added the Sunflower seed packet, which can be found next to the sun counter on the top left corner of the screen. </li>
    <li> Coded plant image to load with the mouse while mouse is being dragged. </li>
</ul>

#### Jamie
<ul>
   <li> Synced the production rates of peas and suns from the plants based on frameCount. </li>
   <li> Fixed Zombie movement while looping through Collideables to recognize peashooters and sunflowers after matching up their image coordinates. </li>
   <li> Included buying feature so the player can only purchase a plant if they have enough suns. </li>
</ul>

### 2019-05-21

#### Pair work
<ul>
   <li> Added a seed packet at the top left corner of the screen to plant new Peashooters. </li>
   <li> Coded a mouse drag function so the player can plant a Peashooter in the desired plot. </li>
</ul>

#### Sabrina
<ul>
   <li> Created the sun counter class to keep track of number of suns collected and available. </li>
   <li> Added display and update methods to show the counter on the top left corner of the screen and increase the number of suns when a sun is collected.  </li>
</ul>

#### Jamie
<ul>
   <li> Added snap-coordinates and proper spacing between plants. </li>
   <li> Fixed bug in mouse drag function by adding variables for the area clicked and length of time the mouse is held down. </li>
</ul>

### 2019-05-20

#### Pair work
<ul>
   <li> Added peas for the peashooters and positioned them based on the Peashooter coordinates. </li>
   <li> Started writing code to move the pea towards the zombies and attack, but encountered issues with collision recognition. </li>
</ul>

#### Jamie
<ul>
   <li> Created Displayable, Moveable, and Collideable Pea class in order to treat each pea as a recognized collideable object for zombies. </li>
   <li> Added hitting and coordinate resetting to Pea, so peashooter can attack again after a target has been hit. </li>
   <li> Included a moveable sun for the sunflower, and coded method to recognize sun collection when it is clicked. </li>
</ul>

### 2019-05-19

#### Sabrina
<ul>
   <li> Edited move() code so that Zombie stops when it touches a plant that is alive. </li>
   <li> Started implementing plant removal from the game screen when its HP runs out after a zombie attacks. </li>
</ul>

#### Jamie
<ul>
   <li> Resolved issue of removing Peashooter when its HP reaches 0 by including an index to refer to a Collideable while looping through the list of Collideables, and including both Plant and Zombie attacks in one traversal ehtough the list. </li>
   <li> Successfully coded an attack and kill function for the Peashooter against the zombies, but have not yet added pea balls. </li>
</ul>

### 2019-05-17

#### Pair work
<ul>
   <li> Implemented the Moveable, Displayable, and Collideable interfaces. </li>
   <li> Coded the specific isTouching() method for Plant and Zombie, based on overlapping coordinates. </li>
   <li> Added the attack and takeHit methods to zombies for mutual attacks between BasicZombie and Peashooter. </li>
</ul>

### 2019-05-16

#### Pair work
<ul>
   <li> Added the background image from Plants vs. Zombies as a reference for coordinates to place our plants and zombies. </li>
   <li> Used rectangles to determine the plant coordinates of one plot of land and added a Peashooter based on those coordinates. </li>
   <li> Coded the Zombie and BasicZombie constructors and basic accessor methods. </li>
   <li> Included a Displayable interface and applied it to the Plant and Zombie classes. </li>
</ul>
