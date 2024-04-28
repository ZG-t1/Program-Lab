// Automatisation

// Fenetre de dialogue pour savoir ou sont les images à prendre au début
WhereAreInitialImages = getDirectory("la ou est l'image a traiter au début");
// Fenetre de dialogue pour savoir ou mettre les datas à la fin
HereAreFinalResults = getDirectory("_la ou sont les résultats");

// list des dossiers
list = getFileList(WhereAreInitialImages);
setBatchMode("false");

for (i=0; i < list.length; i++) {
    open(WhereAreInitialImages + list[i]);
    rename("cell");

    // Keep only LysoTracker channel
    run("Split Channels");
    close();
    close();
    run("Enhance Contrast", "saturated=0.35");
    run("Duplicate...", " ");

    // Segmentation process
    run("Trainable Weka Segmentation");
    wait(1000);
    call("trainableSegmentation.Weka_Segmentation.loadClassifier", "C:\\Users\\zg_pc\\Desktop\\Condition 1\\classifierLysoTracker 047-0900.model");
    call("trainableSegmentation.Weka_Segmentation.getResult");

    // Analysis post-segmentation
    selectImage("Classified image");
    run("Invert");
    run("Enhance Contrast", "saturated=0.35");
    run("Subtract...", "value=254");
    run("Enhance Contrast", "saturated=0.35");
    imageCalculator("Multiply create", "C1-cell", "Classified image");
    selectImage("Result of C1-cell");

    run("Set Measurements...", "area mean min center redirect=None decimal=3");

    setThreshold(100, 65535, "raw");

    run("Analyze Particles...", "size=2-Infinity pixel display overlay add");
    saveAs("Results", "C:/Users/zg_pc/Desktop/Condition 2/Results.csv");
}