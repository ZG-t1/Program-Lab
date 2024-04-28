rename("cell");

//Keep only LysoTracker channel
run("Split Channels");
close();
close();
run("Enhance Contrast", "saturated=0.35");
run("Duplicate...", " ");
wait(1000)
//Segmentation process
run("Trainable Weka Segmentation");
wait(1000)
call("trainableSegmentation.Weka_Segmentation.loadClassifier", "C:\\Users\\zg_pc\\Desktop\\Condition 1\\classifierLysoTracker 047-0900.model");
wait(1000)
call("trainableSegmentation.Weka_Segmentation.getResult");
wait(1000)

//Analysis post-segmentation
selectImage("Classified image");
run("Invert");
run("Enhance Contrast", "saturated=0.35");
run("Subtract...", "value=254");
run("Enhance Contrast", "saturated=0.35");
imageCalculator("Multiply create", "C1-cell","Classified image");
selectImage("Result of C1-cell");

run("Set Measurements...", "area mean min center redirect=None decimal=3");

setThreshold(100, 65535, "raw");

run("Analyze Particles...", "size=2-Infinity pixel display overlay add");
saveAs("Results", "C:/Users/zg_pc/Desktop/Condition 2/Results.csv");

