# MKS22X-FinalProject

## Description

## Development Log

###2019-05-22
We fixed the sun counter so that it will update itself when a sun is clicked on and it is displayed at the top next to the seeds that a user can pick from. We also included a seed packet for the sunflower so that the player can drag the sunflower over the the field. We also created a Character parent class to encapsulate the overlaying methods that were utilized in both the plant and the zombie classes. We changed the time of the production of peas and suns from the plants so that it is synced with the frames per second. Also, the user cannot purchase a plant if they don't have enough suns. 

### 2019-05-21
We added a seed packet at the top left corner of the screen and tried to implement a mouse drag function so that the player can plant a Peashooter in the desired plot of land. We had trouble getting the snap-coordinates of the plants right, and we also had trouble with the mouse drag only being recognized sometimes. We experimented with the y- and x- coordinate intervals of the snap grid, and discovered that the mouse drag was not being registered due to improper range specification of the size of the seed packet.

### 2019-05-20
We added a pea and positioned it based on the Peashooter coordinates, and we were planning to move the pea to shoot the Zombie. In order to do this, we created a Pea class for the shooting peas, and managed to make the pea displayable, moveable, and collideable. The pea disappears after hitting a zombie and its coordinates reset, so the peashooter can attack again after a target has been hit. We also added a moveable sun to the sunflower, and coded the collected() method so that the sun disappears when it is clicked, or collected by the player.

### 2019-05-19
We modified the movement code so that the zombie stops when it touches a plant that is still alive, then attacks. We had trouble getting rid of the Plant when the HP reaches 0, but we resolved the issue by adding an integer index while looping through Collideables. We succeeded in making the plant disappear after being killed, while the zombie continues on the screen if it is still alive. We also got the peashooter to attack and kill the zombie, but have not yet added the shooting pea balls. We encountered an issue with ConcurrentModificationException, which we resolved by including the plant and zombie attack code in the one traversal of Collideables in BasicZombie move().

### 2019-05-17
Today, we added a Moveable interface and created Displayable and Moveable interfaces for the plants and zombies. We included a Collideable interface and isTouching() method for Plant and Zombie. Afterwards, we added the attack and takeHit methods to Zombie, so that the Zombie attacks Plants when touching and vice versa.

### 2019-05-16
Today, we added the background image from Plants vs. Zombies as a reference for coordinates to place our plants and zombies. We used rectangles to determine the plant coordinates of one plot of land and dded a Peashooter based on those coordinates. We also added the Peashooter, Sunflower, and Sun classes. We then added the Zombie and BasicZombie constructors and basic accessor methods. Afterwards, we added a Displayable interface and made it work for all Plant and Zombie classes.
