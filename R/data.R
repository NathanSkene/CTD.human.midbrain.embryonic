#' Human Embryonic Midbrain raw expression data
#'
#' The raw expression and annotation data for the human embryonic midbrain. If you want to regenerate the just download the data from GSE76381. The annotation labels are customised below.
#'
#' @source
#' The code to prepare the .Rda file file from the marker file is:
#' \code{
#' raw_sc_expression_data = process_raw_sc_data()
#' usethis::use_data(raw_sc_expression_data,overwrite=TRUE)
#' }
#'
"raw_sc_expression_data"

#' Human Embryonic Midbrain cell type data file
#'
#' The processed data for the human embryonic midbrain, ready for use in MAGMA_Celltyping and EWCE
#'
#' @source
#' The code to prepare the .Rda file file from the marker file is:
#' \code{
#' library(EWCE)
#' data(raw_sc_expression_data)
#' raw_sc_expression_data$exp_CORRECTED = fix.bad.hgnc.symbols(raw_sc_expression_data$exp)
#' raw_sc_expression_data$exp_CORRECTED_DROPPED = drop.uninformative.genes(exp=raw_sc_expression_data$exp_CORRECTED, level2annot = raw_sc_expression_data$annot$level2class)
#' fNames = generate.celltype.data(exp=raw_sc_expression_data$exp_CORRECTED_DROPPED,raw_sc_expression_data$annot,"HumanEmbyronicMidbrain")
#' load(fNames[1])
#' usethis::use_data(ctd,overwrite=TRUE)
#' }
#'
"ctd"


