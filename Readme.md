Human Midbrain Embryonic Dataset
================
Nathan Skene
2018-12-05

<!-- Readme.md is generated from Readme.Rmd. Please edit that file -->
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("h1").className = "title";
});
</script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  var links = document.links;  
  for (var i = 0, linksLength = links.length; i < linksLength; i++)
    if (links[i].hostname != window.location.hostname)
      links[i].target = '_blank';
});
</script>
Installation
------------

    install.packages("devtools")
    library(devtools)
    install_github("nathanskene/CTD.human.midbrain.embryonic")

Human Midbrain Embryonic Dataset
--------------------------------

This package provides easy access to the human midbrain embryonic dataset, which is associated with the following paper:

[La Manno G, Gyllborg D, Codeluppi S, Nishimura K et al. Molecular Diversity of Midbrain Development in Mouse, Human, and Stem Cells. Cell 2016 Oct 6;167(2):566-580.e19. PMID: 27716510](https://www.cell.com/cell/fulltext/S0092-8674(16)31309-5)

The raw data is available along with annotations:

``` r
library(CTD.human.midbrain.embryonic)
data(raw_sc_expression_data)
raw_sc_expression_data$exp[1:5,1:5]
raw_sc_expression_data$annot[["level2class"]][1:10]
raw_sc_expression_data$annot[["level1class"]][1:10]
```

Should you wish to regenerate the data from scratch then the code for doing so is available in `process_raw_sc_data()`. I suggest forking this project, modifying the code for this function in there.

The processed cell type data (ctd) for use in MAGMA\_Celltyping and EWCE is also available using:

``` r
library(CTD.human.midbrain.embryonic)
data(ctd)
```

Preparing cell type data file
-----------------------------

``` r
library(EWCE)
raw_sc_expression_data$exp_CORRECTED = fix.bad.hgnc.symbols(raw_sc_expression_data$exp)
raw_sc_expression_data$exp_CORRECTED_DROPPED = drop.uninformative.genes(exp=raw_sc_expression_data$exp_CORRECTED, level2annot = raw_sc_expression_data$annot$level2class)
fNames = generate.celltype.data(exp=raw_sc_expression_data$exp_CORRECTED_DROPPED,raw_sc_expression_data$annot,"HumanEmbyronicMidbrain")
```

We can check the results are as expected:

``` r
load(fNames[1])
print(ctd[[1]]$specificity[1:5,1:5])
print(sort(ctd[[1]]$specificity[,"Embryonic Dopaminergic Neuron"],decreasing = TRUE)[1:20])
```
