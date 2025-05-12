## Solution:

```
process COUNT_BASEPAIRS {
	input:
	path fasta
	
	output:
	path "num_basepairs.txt", emit: num_basepairs
	
	script:
	"""
	tail -n +2 $fasta | tr -d '\n' | wc -m > num_basepairs.txt
	"""
}
```
