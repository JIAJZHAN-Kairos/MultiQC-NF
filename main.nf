process MULTIQC {

    container "ewels/multiqc:latest"

    input:
    val input_dir

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
      --ignore "*.fastq"
    """
}

workflow {
    MULTIQC(params.input)
}
