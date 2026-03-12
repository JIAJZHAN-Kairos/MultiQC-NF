nextflow.enable.dsl=2

params.input  = null
params.outdir = null

process MULTIQC {

    container "ewels/multiqc:latest"
    publishDir "${params.outdir}", mode: 'copy'

    input:
    path input_dir

    output:
    path "multiqc_report.html"
    path "multiqc_data"

    script:
    """
    multiqc ${input_dir} \
      --dirs \
      --ignore "*.bam" \
      --ignore "*.cram" \
      --ignore "*.vcf" \
      --ignore "*.vcf.gz" \
      --ignore "*.g.vcf" \
      --ignore "*.bcf" \
      --ignore "*.fastq" \
      --ignore "*.fq" \
      --force
    """
}

workflow {
    Channel
        .fromPath(params.input, checkIfExists: true)
        .set { input_ch }

    MULTIQC(input_ch)
}
