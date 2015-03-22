# Survival API

## the problem

You, the survivor of a zombie apocalypse, are probably in search of an easy way to determine which of the resources you stumble upon to save in your pack. You have one pack to survive; it's got limited capacity.

You move hurriedly from town to town, amassing potentially useful resources in a pile (AKA a JSON file) at a rest stop, but the time comes when you need to travel further, and choose what to bring with you as you travel.

This may happen to anyone at various apocalypse central locales around the world, so we've created [an API]() to solve your problem.

Should you wish to improve upon this lifesaving solution, this code is [licensed]() under the [MIT license]() and available, with test data, in [this here repository]().

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

Make a request to the API at: <URL>

At the endpoint ```v1/SurvivalPack```.

Here is an example request:

```
code for request here
```

---

**best of luck, fellow human.**


