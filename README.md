
![image](https://raw.githubusercontent.com/rai-hi/ca-skin-patterning/master/SkinSim/Images/regyoung.png)

# Ruby/Rails Skin Patterning Simulation
This project is a web app, allowing you to simulate skin pattern development in animals (e.g. leopards, zebra and dogs).

It is based on work I did during my dissertation, which you can find [here](https://github.com/rai-hi/ca-skin-patterning).

## What does it simulate?
Biologists aren't sure how skin patterns develop in the womb, and so have come up with several possible explanations. Most agree that their is no central design, but more likely develop based on short-range chemical interaction betwen nearby skin cells.

Even with incredibly simple rules for the interaction between skin cells, complex patterns like spots, patches and stripes quickly emerge and stabilise.

It is this process of development that the app simulates.

## Installation
The app is a simple Rails 5 app, which you can run with `bin/rails server`.

## Running a simulation
Navigate to the root page (usually `localhost:3000/`).

When the page first loads, a simulation will run in the background on the server. Once it's done, it will play out in the canvas at the top of the page. Click the `replay` button to view it again.

To reproduce other types of pattern, select a preset from the dropdown in the panel at the bottom, and press simulate. Once complete, it will be played in the top box.

To understand the other controls and come up with your own simulations, read the `Advanced usage` section. In order to understand it, you may want to also read the `Model information` section.

## Demo
You can view a running demo of the project at [this link](https://skin-simulator.herokuapp.com).

## Model information
In this app's model, each skin cell emits two chemicals. One chemical makes it more likely that nearby cells will become pipgmented, and the other makes it less likely. The amount of each chemical released by a cell is based on how strong the concentration of the chemicals around it are.

The concentrations of these chemicals eventually finds an equilibrium, causing the pattern to be fixed and colour to emerge.

You can read more about the various models in the dissertation document [here](https://github.com/rai-hi/ca-skin-patterning/blob/master/Dissertation%20PDF/DissertationFinal.pdf). Only the Wolfram model is currently implemented.


## Advanced usage
You can also adjust the strength of the chemicals yourself, to come up with other interesting patterns. Using small increments, adjust the strengths with the two sliders and click simulate to see how they affect the simulation.

**Bear in mind, the strengths are very sensitive to each other, and it's easy to end up with patterns that are just a single colour. Try choosing a preset again, and adjust the sliders by very small increments. Press simulate, and see how the pattern has changed before adjusting the sliders further.**

