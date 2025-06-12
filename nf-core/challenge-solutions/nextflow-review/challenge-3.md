workflow {
    reads_ch = channel.fromFilePairs('data/fastqs/*_{R1,R2}.fastq.gz')

    TRIM_READS(reads_ch)

    READ_QC(TRIM_READS.out.trimmed_reads)

    QC_REPORT(READ_QC.out.qc_files)

    output_ch = QC_REPORT.out.qc_report
}
