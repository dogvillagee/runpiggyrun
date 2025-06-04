RunPiggy Is a 3D infinite runner sort of similar to subway surfers and temple run. music, code, and most sounds are done by me. I hope to release it on AddictingGames.com and Itch.io soon!

![image alt](https://github.com/dogvillagee/runpiggyrun/blob/a757768070df257496ab6f74c22d5138f0bd91f3/piggy_demo_sc.png)

The code for the procedural generation can be found under the scripts folder titled 'terrain_controller.gd'. The basic idea is that it casts
a random terrain block scene from the terrain_blocks folder and spawns them in a row, while also moving them backwards at a constant speed to simulate movement.
When a terrain block is out of view, it's popped from the front of the stack and replaced with a new one at the back
![image alt](https://github.com/dogvillagee/runpiggyrun/blob/a757768070df257496ab6f74c22d5138f0bd91f3/Untitled%20Diagram.drawio%20(5).png)

