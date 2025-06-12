# A brief review of Nextflow

| Questions  | Objectives |
| ------------- | ------------- |
| What is a Nextflow channel?  | Define what a channel is and explain the difference between queue and value channels. |
| What is a Nextflow process?  | Define what a process is and explain the three main parts of a process. |
| What is a Nextflow workflow?  | Define what a workflow is and explain how processes and channels together make workflows. |

Nextflow is a workflow system for creating scalable, portable, and reproducible workflows in which command line tools can be chained together to create a complex workflow. In this episode, we will briefly review the fundamentals of the Nextflow language: channels, processes, and workflows. These foundational principles are necessary to understand and script in the Nextflow language. 

To help conceptulize this episode, consider lego bricks and builds as a metaphor: Workflows are the completed build, processes are the actual block pieces composing the completed build, and channels are the studs that protude from the brick to connect each piece. 

## Channels
From a high level perspective, channels are used as a way to transfer data from one step to the next.

Channels can store items, such as files (e.g., fastq files) or values (e.g., the number of reads).

Nextflow distinguishes between two different kinds of channels: **queue** channels and **value** channels.

### Queue channels
A queue channel connects a producer process (a process that outputs a value) to a consumer process (a process that takes in a value) or an operator. A queue channel is consumed and can only be used **once**.

Queue channels can be created using the following methods (also known as ["channel factories"](https://www.nextflow.io/docs/latest/reference/channel.html#)):

-   `Channel.of`: Create a channel that emits the arguments provided to it.
-   `Channel.fromList`: Create a channel emitting the values provided from a list.
-   `Channel.fromPath`: Create a channel emitting one or more file paths.
-   `Channel.fromFilePairs`: Creates a channel emitting the file pairs matching a glob pattern.
-   `Channel.fromSRA`: Queries the NCBI SRA database and returns a channel emitting the FASTQ files matching a project or accession number(s).

We will use `Channel.of` and `Channel.fromPath` as examples:

```
species_ch = Channel.of( 'E. coli', 'K. pneumoniae', 'M. morganii' )
```

In this example, we've created the variable `species_ch`. `species_ch` is a queue channel containing three values (species names). The values are the arguments of the method.

Viewing the channel using `species_ch.view()` will produce the following output:

```
E. coli
K. pneumoniae
M. morganii
```

You can create a queue channel with multiple files matching a specific pattern using glob syntax. There are multiple characters used in glob syntax, but for our example we are going to use the asterisk `*`. You can read more about glob pattern matching characters [here](https://developers.tetrascience.com/docs/common-glob-pattern).

```
reads_ch = Channel.fromPath( 'outbreak/fastq_data/*.fastq.gz' )
```

In the example above, using `*` specifies that we want to grab every file ending in `.fastq.gz` in the `outbreak/fastq_data/` directory for the `reads_ch` channel.

Viewing the `reads_ch` using `reads_ch.view()` will produce the following output:

```
outbreak/fastq_data/sample1_R1.fastq.gz
outbreak/fastq_data/sample1_R2.fastq.gz
outbreak/fastq_data/sample2_R1.fastq.gz
outbreak/fastq_data/sample2_R2.fastq.gz
outbreak/fastq_data/sample3_R1.fastq.gz
outbreak/fastq_data/sample3_R2.fastq.gz
```

### Value channels

A **value** channel consists of a **single** value, which can be consumed multiple times by a process or operator. 

```
microbe_ch = Channel.value('bacteria')
```

Viewing the `microbe_ch` using `microbe_ch.view()` will produce the following output:

```
bacteria
```

**Note:** A list of multiple values counts as a single item and can be assigned to a value channel. In this example, which assigns a list of microbes to the channel `microbes_ch`:

```
microbes_ch = Channel.value( ['bacteria','viruses','yeast'] )
```

Viewing the `microbe_ch` using `microbe_ch.view()` will produce the following output:

```
['bacteria','viruses','yeast']
```

#### Challenge 1

How would you create a queue channel named `fasta_ch` of files with the `.fasta` extension found in a directory named `data/fasta_files/`?

The solution to this challenge can be found [here](/nf-core/challenge-solutions/nextflow-review/challenge-1.md).

## Processes

Processes are the individual actions that make up a workflow. Nextflow uses processes to execute commands or scripts the same way you would run a command on the command line. Processes are independent of each other, and data is passed between them via input and output channels. These channels allow Nextflow to coordinate the execution of each step in the workflow.

#### How channels connect processes

The figure below visually represents how channels pass data to processes:

<img src ='/nf-core/assets/nextflow-review/workflow-example.drawio.png'>  

This workflow takes `File 1` as input. That input is passed to `Process X` via `Channel A`. `Process X` performs a task, and the output of that task is passed (aka emitted) to `Process Y` by `Channel B`. `Process Y` performs a task, and the output of that task is passed to `Channel C`.


### Anatomy of a process

In this section, we're going to discuss three key components of a process: The script, input, and output blocks.

A process is made up of the process function, a name, and a body. The name of the process describes what that process is doing while the body (which is contained in curly brackets`{}`) consists of the command or script that process executes.

```
process HELLO {
  script:
  """
  echo "Hello world!"
  """
}
```

In the example above, the process `HELLO` executes the command `echo "Hello world!"`.

**Note:** The HELLO process above does not need an input or output block because it returns text.

### The script block

The script block defines the script or command executed by the process. A process must define a script or exec section. We are not going to review exec sections in this episode, but you can read more about them [here](https://www.nextflow.io/docs/latest/process.html#native-execution). All other sections in a process are optional.

In the `HELLO` process described above, the script section was defined using the word `script` 

Here is another example of the script block:

```
process COUNT_SEQUENCES {
	script:
	"""
	grep -c ">" $fasta > num_sequences.txt
	"""
}
```

The script block in this process executes the `grep` command in order to count the number of sequences in a fasta file. We'll build on this example process for the rest of this section.

### The input block

The input block defines the input channels of a process, similar to arguments in a function. A process can have only one input block, which must contain at least one input.

The input block is defined using the word `input` and the following syntax:

```
input:
  <input qualifier> <input name>
```
 
Inputs consist of a qualifier and a name. The qualifier defines what type of data is be received.

The list of input qualifiers includes:

-   `val`: Access the input value by name in the process script.
-   `path`: Handle the input value as a path, staging the file properly in the execution context. 
-   `env`: Use the input value to set an environment variable in the process script.
-   `stdin`: Forward the input value to the process `stdin` special file.
-   `tuple`: Handle a group of input values having any of the above qualifiers. 
-   `each`: Execute the process for each element in the input collection.

`val`, `path`, and `tuple` are the most common qualifiers you are likely to use.

The input block is contained within the process body, **before** the script block, like so:

```
process COUNT_SEQUENCES {
	input:
	path fasta 
	
	script:
	"""
	grep -c ">" $fasta > num_sequences.txt
	"""
}
```

### The output block

The output block defines the output channels of a process, similar to the output of a function. A process can have only one output block, which must contain at least one output.

The output block is defined using the word `output` and the following syntax:

```
output:
  <output qualifier> <output name>
```

An output definition consists of a qualifier and a name, just like an input definition.

When a process is called, each output is returned as a channel. Like the input, the type of output data is defined using qualifiers.

The list of output qualifiers includes:

-   `val`: Emit the variable with the specified name. 
-   `path`: Emit a file produced by the process with the specified name.  
-   `env`: Emit the variable defined in the process environment with the specified name.  
-   `stdout`: Emit the `stdout` of the executed process.  
-   `tuple`: Emit multiple values. 
-   `eval`: Emit the result of a script or command evaluated in the task execution context.

Again, `val`, `path`, and `tuple` are the most common qualifiers you are likely to use.

The output block is contained within the process body, **after** the input block and **before** the script block, like so:

```
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
```

The output block in this example returns a file called `num_sequences.txt`, which is produced by the code in the script block. The grep commands counts the number of sequences in the fasta file by counting the number of greater than signs `>` in the file. That number is then stored in a file named `num_sequences.txt`.

The `emit` option included in the output block allows you to assign an identifier that you can use to reference the channel (more on that in the Workflow section).

#### Challenge 2

Create a process named `COUNT_BASEPAIRS` that takes in a fasta file from a path as `fasta`, runs the command `tail -n +2 $fasta | tr -d '\n' | wc -m > num_basepairs.txt`, and emits a file named `num_basepairs.txt` as `num_basepairs`. What are the qualifiers and names of the input and output of this process?

The solution to this challenge can be found [here](/nf-core/challenge-solutions/nextflow-review/challenge-2.md).

### Workflows

In Nextflow, workflows connect multiple processes and the channels that pass data between them. We define our workflow in a script (ending `.nf`) using the `workflow` definition, and the workflow body is contained within curly brackets `{}`.

In this section, we're going to go over a two step workflow that takes in paired FASTQ files, assembles the reads into genomes using the [shovill](https://github.com/tseemann/shovill) assembler and assesses their quality using [QUAST](https://quast.sourceforge.net/). The first two blocks of the script are processes, `ASSEMBLY` and `ASSEMBLY_QC`. The final block is the workflow itself:

```
 process ASSEMBLY {    
    input:
    tuple val(sample_name), path(reads)
    
    output:
    tuple val(sample_name), path("${sample_name}.contigs.fa"), emit: assemblies
   
    script:
    """
    shovill --R1 ${reads[0]} --R2 ${reads[1]} --outdir ./shovill_output --force
    mv shovill_output/contigs.fa ${sample_name}.contigs.fa
    """
}

process ASSEMBLY_QC {    
    input:
    tuple val(sample_id), path(assemblies)
    
    output:
    tuple val(sample_id), path("${meta.id}.quast.report.tsv")
    
    script:
    """
    quast.py ${assemblies} -o .
    mv report.tsv ${sample_id}.quast.report.tsv
    """
}

workflow {
    reads_ch = channel.fromFilePairs('outbreak/fastq_data/*_{R1,R2}.fastq.gz')

    ASSEMBLY(reads_ch)

    ASSEMBLY_QC(ASSEMBLY.out.assemblies)
}
```

Here is a visual representation of the workflow in the same format as the 'How channels connect processes' diagram above:

<img src ='/nf-core/assets/nextflow-review/assembly-workflow.drawio.png'>  

Now let's break down the workflow block line by line:

```
workflow {
    reads_ch = channel.fromFilePairs('outbreak/fastq_data/*_{R1,R2}.fastq.gz')

    ASSEMBLY(reads_ch)

    ASSEMBLY_QC(ASSEMBLY.out.assemblies)
}
```

The first line in the workflow creates a channel called `reads_ch` using `channel.fromFilePairs()`. This channel contains paired fastq files found in the `outbreak/fastq_data/` directory:

```
reads_ch = channel.fromFilePairs('outbreak/fastq_data/*_{R1,R2}.fastq.gz')
```

The second line calls the `ASSEMBLY` process, using the `reads_ch` channel as input:

```
ASSEMBLY(reads_ch)
```

The third line calls the ASSEMBLY_QC process and uses the output emitted from the `ASSEMBLY` process as input. The `ASSEMBLY` output is accessed using the `.out` attribute:

```
ASSEMBLY_QC(ASSEMBLY.out.assemblies)
```

It's important to note that Nextflow allows for some formatting differences in the workflow block:

```
    channel
        .fromFilePairs(
            'outbreak/fastq_data/*_{R1,R2}.fastq.gz',
            checkIfExists: true
        )
        .set { reads_ch }

    ASSEMBLY(
        reads_ch
        )

    ASSEMBLY_QC(
        ASSEMBLY.out.assemblies
        )
```

In the example above, the channel operators and process inputs are on separate lines, and those lines are indented. Some people find that this helps with the readability of the workflow, and it is up to individual preference.

With that brief review of Nextflow complete, we can move on to downloading and running nf-core workflows in the next episode.

#### Challenge 3

Create a workflow block with the following input and processes: 
- The input is a path to paired end FASTQ files `data/fastqs/*_{R1,R2}.fastq.gz`.
- Process one is `TRIM_READS()`, which takes the FASTQ files as input. It emits an output with the name `trimmed_reads`.
- Process two is `READ_QC()`, which takes the output of `TRIM_READS()` as input. It emits an output with the name `qc_files`.
- Process three is `QC_REPORT()`, which takes the output of `READ_QC()` as input. It emits an output called `qc_report`.

The solution to this challenge can be found [here](/nf-core/challenge-solutions/nextflow-review/challenge-3.md).

## Keypoints

1. Nextflow channels are used to transfer information between processes.
  - The two types of channels can be used in different ways:
    - Queue channels are able to be used once and can store multiple values.
    - Value channels can be used multiple times but are composed of one value.
2. Nextflow processes are the actions that are executed.
  - They are made up of the process function, a name, and a body.
3. Nextflow workflows combine processes and channels together to perform a string of actions.


