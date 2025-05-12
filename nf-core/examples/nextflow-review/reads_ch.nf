reads_ch = Channel.fromPath( 'outbreak/fastq_data/*.fastq.gz' )
reads_ch.view()
