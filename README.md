# Survival API

## the problem

You, the survivor of a zombie apocalypse, are probably in search of an easy way to determine which of the resources you stumble upon to save in your pack. You have one pack to survive; it's got limited capacity.

You move hurriedly from town to town, amassing potentially useful resources in a pile (AKA a JSON file) at a rest stop, but the time comes when you need to travel further, and choose what to bring with you as you travel.

This may happen to anyone at various apocalypse central locales around the world, so we've created an API to solve your problem.

Should you wish to improve upon this lifesaving solution, this code is [licensed]("https://github.com/aerenchyma/survival-pack-api/blob/master/LICENSE") under the [MIT license]("http://opensource.org/licenses/MIT") and available, with test data, in this here repository.

Save the reportedly tasty brains.

## the solution

### you need

- internet access
- the bundler ruby gem / ability to install ruby gems on your machine
- knowledge of the weight capacity of your pack
- a JSON file of your available resources, formatted like so:

```
{'maxwt': <maximum weight your pack can hold>,
	'data': {
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

Should you have things formatted in a tab-delimited file, like in the ``` tabdelim_testdataLO.tsv ``` file provided, you can run the ``` convert_tab_data.py ``` file (found in the ``` api/data ``` folder) with your .tsv file name as a command line argument (e.g. ``` python convert_tab_data.py tabdelim_testdataLO.tsv newlyformatted_testdataLO.json ```), which will produce a JSON file formatted properly.

With those listed things at hand, you can make a survival request to the API.

### you must

Make a request to the API:

Here is an example request:

```
curl -H "Content-Type: application/json" --data @api/data/testdataLO.json https://survival-pack.herokuapp.com/v1/survival-pack > "testdataLO_OUTPUT.json"
```
or in more general terms,

```
curl -H "Content-Type: application/json" --data @api/data/<file path>.json https://survival-pack.herokuapp.com/v1/survival-pack

```

If you clone this repository and want to deploy it yourself (e.g. to [Heroku]("http://heroku.com"), where this is deployed), you should replace ``` https://survival-pack.herokuapp.com/ ``` with your own URL.

Given the ``` testdataLO.json ``` file I've provided, for example, you would get the following response, which could then be parsed in another program or by human eyes desperate to survive:

```
{"survival-pack":{"pack_items":"map, water, glucose, banana, suntan cream, waterproof overclothes, sunglasses, socks, compass, sandwich, waterproof trousers, note-case","total_weight":396,"total_value":1030}}
```

### to run it yourself

1. Clone the repository, then ``` cd ``` inside the directory.

2. ``` bundler install ```

3. ``` rackup ``` (to run locally, or else deploy elsewhere)

### to test

In ``` api/data ```, there are several test data files. Each file whose name has **(any one word).JSON** is a sample input .JSON file which can replace ``` <file path> ``` in the request format.

Each file whose filename is the same as another, except that it ends with ``` _OUTPUT.JSON ```, is a mirror of the output you ought to get from the corresponding input file.
