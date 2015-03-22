# Survival API

## the problem

You, the survivor of a zombie apocalypse, are probably in search of an easy way to determine which of the resources you stumble upon to save in your pack. You have one pack to survive; it's got limited capacity.

You move hurriedly from town to town, amassing potentially useful resources in a pile (AKA a JSON file) at a rest stop, but the time comes when you need to travel further, and choose what to bring with you as you travel.

This may happen to anyone at various apocalypse central locales around the world, so we've created an API to solve your problem.

Should you wish to improve upon this lifesaving solution, this code is [licensed]("/license") under the [MIT license]("http://opensource.org/licenses/MIT") and available, with test data, in this here repository.

Save the reportedly tasty brains.

## the solution

### you need

- internet access
- knowledge of the weight capacity of your pack
- a JSON file of your available resources, formatted like so:

``` 
{'maxwt': <maximum weight your pack can hold>,
 'data':
	{
	'items' : {
		'<item name>': {
			"weight": <item weight>,
			"value": <item value>
		} 
	}	
  }

} 
```

Note that a dictionary like that above, with the keys "weight" and "items", should exist for each item available in your pile. That dictionary for each item should be a value in the dictionary beneath **data > items**, and the key to its value should be the item name.

With those three things at hand, and your item pile structured as described, you can make a survival request to the API.

### you must

Make a request to the API:

Here is an example request:

```
curl -H "Content-Type: application/json" --data @<filename>.json http://<url>/v1/survival-pack  

update when deployed
```

Given the ``` testdataLO.json ``` file I've provided, for example, you would get the following response, which could then be parsed in another program or by human eyes desperate to survive:

```
{"survival-pack":{"pack_items":"map, water, glucose, banana, suntan cream, waterproof overclothes, sunglasses, socks, compass, sandwich, waterproof trousers, note-case","total_weight":396,"total_value":1030}}
```

### to test

In ``` api/data ```, there are several test data files. Each file whose name has **(any one word).JSON** is a sample input .JSON file which can replace ``` <filename> ``` in the request format. 

Each file whose filename is the same as another, except that it ends with ``` _OUTPUT.JSON ```, is a mirror of the output you ought to get from the corresponding input file.

#### (you should know)

- Some of the code I used to solve the knapsack problem is translated from a solution of the knapsack problem I turned in for an data structures and algorithms class. Naturally, it's rather different here; I wrote that version in Python. Variable names, however, are the same.

- To build the API framework, I read several sample Grape applications and modeled on top of one. Initially, I thought of using Rails, but inspecting the documentation, it was clear there was a simpler way to do this.

- What I care most about in RESTful APIs as a developer is clarity. I want to know precisely what I need to input and precisely what I will get back, or should expect to get back. As a result, I've considered or implemented the following:
	- This readme (an API's readme file is extremely important to me)
	- If I were to continue this development, I would include an Angular front-end for trying various endpoints of the API as they existed (I've chosen not to do the Extra Credit because my experience with JavaScript front ends is a bit more limited than my model + controller experience, and I'm hoping to complete an efficiency suite for Instructional Assistants in the class I teach to grade assignments with this weekend as well)
	- Speaking of multiple endpoints, I've also thought about, though not implemented, the following endpoints in particular: pack-metrics (this would include mean values of pack weights and values given previously entered data -- this is for people to decide what to bring with them for survival, after all), common-items (these would both require a database not used here)

---

**best of luck, fellow human.**


