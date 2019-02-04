# Rocket-Gas-Thruster-Control
Rocket flight simulations and GN&amp;C using cold gas thrusters.

I will upload my work here as I complete it. Descriptions of files will also be put here when I upload them.

Initial code adapted from a project I did last year modeling a water bottle rocket in flight


Main: the main differential function that feeds into the ode45

test: a script to test various parameters and then calls ode45 on "Main" and plots h(t) and V(t)



Sources:
https://www.grc.nasa.gov/www/k-12/airplane/rockth.html (thrust eqn)
https://www.grc.nasa.gov/www/k-12/airplane/drageq.html (drag eqn)
