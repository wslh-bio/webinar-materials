process COUNT_SEQUENCES {
	input:
	path fasta
	
	output:
	path "num_sequences.txt", emit: num_sequences
	
	script:
	"""
	grep -c ">" $fasta > num_sequences.txt
	"""
}
