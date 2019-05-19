# MKS22X-FinalProject

## Description 

## Development Log

### 2019-05-19
We modified the movement code so that the zombie stops when it touches a plant that is still alive, then attacks. We had trouble getting rid of the Plant when the HP reaches 0, but we resolved the issue by adding an integer index while looping through Collideables. We succeeded in making the plant disappear after being killed, while the zombie continues on the screen if it is still alive. We also got the peashooter to attack and kill the zombie, but have not yet added the shooting pea balls. We encountered an issue with ConcurrentModificationException, which we resolved by including the plant and zombie attack code in the one traversal of Collideables in BasicZombie move().

### 2019-05-17
Today, we added a Moveable interface and created Displayable and Moveable interfaces for the plants and zombies. We included a Collideable interface and isTouching() method for Plant and Zombie. Afterwards, we added the attack and takeHit methods to Zombie, so that the Zombie attacks Plants when touching and vice versa.

### 2019-05-16
Today, we added the background image from Plants vs. Zombies as a reference for coordinates to place our plants and zombies. We used rectangles to determine the plant coordinates of one plot of land and dded a Peashooter based on those coordinates. We also added the Peashooter, Sunflower, and Sun classes. We then added the Zombie and BasicZombie constructors and basic accessor methods. Afterwards, we added a Displayable interface and made it work for all Plant and Zombie classes.
