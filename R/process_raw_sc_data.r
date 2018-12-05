#' process_raw_sc_data
#'
#' \code{process_raw_sc_data} downloads the raw data from GEO (accession GSE76381) and formats it.
#'
#' @examples
#' raw_sc_expression_data = process_raw_sc_data()
#' usethis::use_data(raw_sc_expression_data,overwrite=TRUE)
#' @export
process_raw_sc_data = function(){
   con <- gzcon(url(paste("ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE76nnn/GSE76381/suppl/","GSE76381%5FEmbryoMoleculeCounts%2Ecef%2Etxt%2Egz", sep="")))
   txt <- readLines(con)
   midbrain_human <- read.csv(textConnection(txt),stringsAsFactors = FALSE,sep="\t")

   exp_HUMAN = midbrain_human[5:dim(midbrain_human)[1],-(1:2)]
   rownames(exp_HUMAN) = midbrain_human[5:dim(midbrain_human)[1],1]
   cellid_HUMAN = midbrain_human[1,-(1:2)]
   colnames(exp_HUMAN) = cellid_HUMAN
   level1class = midbrain_human[2,-(1:2)]
   level1class = gsub("hPeric","Pericytes",level1class)
   level1class = gsub("hMgl","Microglia",level1class)
   level1class = gsub("hEndo","Endothelial",level1class)
   level1class = gsub("hNbGaba","GABAergic Neuroblasts",level1class)
   level1class = gsub("hNProg","Neural Progenitors",level1class)
   level1class = gsub("hProg.*","Progenitor Cells",level1class)
   level1class = gsub("hOPC","Oligodendrocyte Precursor Cells",level1class)
   level1class = gsub("hRgl.*","Radial glia like cells",level1class)
   level1class = gsub("hNbL.","Neuroblasts",level1class)
   level1class = gsub("hNbML.","Neuroblasts",level1class)
   level1class = gsub("hNbM","Neuroblasts",level1class)
   level1class = gsub("hDA.","Embryonic Dopaminergic Neuron",level1class)
   level1class = gsub("hNbDA","Dopaminergic Neuroblast",level1class)
   level1class = gsub("hSert","Serotonergic Neuron",level1class)
   level1class = gsub("hGaba","Embryonic GABAergic Neuron",level1class)
   level1class = gsub("hOMTN","Embryonic midbrain nucleus neurons",level1class)
   level1class = gsub("hRN","Embryonic midbrain nucleus neurons",level1class)
   level2class = midbrain_human[2,-(1:2)]
   level2class = gsub("hPeric","Pericytes",level2class)
   level2class = gsub("hMgl","Microglia",level2class)
   level2class = gsub("hEndo","Endothelial",level2class)
   level2class = gsub("hNbGaba","GABAergic Neuroblasts",level2class)
   level2class = gsub("hNProg","Neural Progenitors",level2class)
   level2class = gsub("hOPC","Oligodendrocyte Precursor Cells",level2class)
   level2class = gsub("hRgl","Radial glia like cells ",level2class)
   level2class = gsub("hNbL","Lateral Neuroblasts ",level2class)
   level2class = gsub("hNbML","Mediolateral Neuroblasts ",level2class)
   level2class = gsub("hNbM","Medial Neuroblasts ",level2class)
   level2class = gsub("hProgBP","Basal Plate Progenitors",level2class)
   level2class = gsub("hProgFPL","Lateral Floorplate Progenitors",level2class)
   level2class = gsub("hProgFPM","Medial Floorplate Progenitors",level2class)
   level2class = gsub("hProgM","Midline Progenitors",level2class)
   level2class = gsub("hDA","Embryonic Dopaminergic Neuron ",level2class)
   level2class = gsub("hNbDA","Dopaminergic Neuroblast",level2class)
   level2class = gsub("hSert","Serotonergic Neuron",level2class)
   level2class = gsub("hGaba","Embryonic GABAergic Neuron ",level2class)
   level2class = gsub("hOMTN","Oculomotor and Trochlear nucleus embryonic neurons",level2class)
   level2class = gsub("hRN","Red nucleus embryonic neurons",level2class)
   annot_HUMAN = data.frame(cellid=t(cellid_HUMAN),level1class=level1class,level2class=level2class)
   colnames(annot_HUMAN)[1] = "cell_id"
   annot_HUMAN = annot_HUMAN[!level1class %in% c("Unk"),]
   exp_HUMAN = exp_HUMAN[,as.character(annot_HUMAN$cell_id)]
   annotLevels = list(level1class=annot_HUMAN$level1class,level2class=annot_HUMAN$level2class)
   raw_sc_expression_data = list()
   raw_sc_expression_data$name  = "Human Embryonic Midbrain"
   raw_sc_expression_data$exp   = exp_HUMAN
   raw_sc_expression_data$annot = annotLevels
   return(raw_sc_expression_data)
}
