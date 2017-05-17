val data = sc.textFile("file:///path/to/data/").map(line => line.split(","))
val splits = data.randomSplit(Array(0.8, 0.2), 0L)
val trainingdata = splits(0).cache()
val testdata = splits(1).cache()