# Running an nf-core pipeline

| Questions  | Objectives |
| ------------- | ------------- |
| Where can I find nf-core pipelines? | Find an nf-core pipeline using the nf-core website and nf-core tools. |
| How do I run nf-core pipelines? | Run an nf-core pipeline on the command line. |
| What is a profile?  | Define what a configuration profile is. |
| How do I test an nf-core pipeline? | Run an nf-core pipeline using the test profile. |

## Finding nf-core pipelines

There are two main ways you can find nf-core pipelines. You can manually search the pipelines page of the nf-core website, found [here](https://nf-co.re/pipelines/), or you can use nf-core tools on the command line.

### Finding nf-core pipelines online

As an example, we'll look at the webpage for nf-core's [demo pipeline](https://nf-co.re/demo/1.0.1/).

Each nf-core pipeline's webpage contains the following information, organized in tabs:

 1. Introduction - A summary of the pipeline
 2. Usage - Instructions on how to run the pipeline
 3. Parameters - A list of the pipeline's parameters, which includes a description of the parameter and their default values
 4. Output - A description of the pipeline's output
 5. Results - An example of the pipeline's results
 6. Releases - The pipeline's version history

Other useful information on a pipeline's webpage includes commands to clone the pipeline, and links to ask a question about the pipeline on Slack or open an issue using GitHub. Some pipelines also feature Youtube Videos on their webpages, which can also be found on [this playlist](https://youtube.com/playlist?list=PL3xpfTVZLcNh0T2JLJ_hRDqdouS4o8ik7&si=I5-zpScD-HGWas3w).

### Finding nf-core pipelines on the command line

nf-core tools is a command line program with a number of helper functions that make it easier for you to work with nf-core pipelines.

You can use the `--help` option to view your version of nf-core tools and its commands:

```
nf-core --help
```

```	


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.2.0 - https://nf-co.re


                                                                                                    
 Usage: nf-core [OPTIONS] COMMAND [ARGS]...                                                         
                                                                                                    
 nf-core/tools provides a set of helper tools for use with nf-core Nextflow pipelines.              
 It is designed for both end-users running pipelines and also developers creating new pipelines.    
                                                                                                    
╭─ Commands ───────────────────────────────────────────────────────────────────────────────────────╮
│ pipelines         Commands to manage nf-core pipelines.                                          │
│ modules           Commands to manage Nextflow DSL2 modules (tool wrappers).                      │
│ subworkflows      Commands to manage Nextflow DSL2 subworkflows (tool wrappers).                 │
│ interface         Launch the nf-core interface                                                   │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                        Show the version and exit.                                      │
│ --verbose        -v              Print verbose output to the console.                            │
│ --hide-progress                  Don't show progress bars.                                       │
│ --log-file       -l  <filename>  Save a verbose log to a file.                                   │
│ --help           -h              Show this message and exit.                                     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯

```

To view pipeline related commands, we need to use the `pipeline` command with the `--help` option:

```

                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.2.0 - https://nf-co.re


                                                                                                    
 Usage: nf-core pipelines [OPTIONS] COMMAND [ARGS]...                                               
                                                                                                    
 Commands to manage nf-core pipelines.                                                              
                                                                                                    
╭─ For users ──────────────────────────────────────────────────────────────────────────────────────╮
│ list                  List available nf-core pipelines with local info.                          │
│ launch                Launch a pipeline using a web GUI or command line prompts.                 │
│ download              Download a pipeline, nf-core/configs and pipeline singularity images.      │
│ create-params-file    Build a parameter file for a pipeline.                                     │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ For developers ─────────────────────────────────────────────────────────────────────────────────╮
│ create         Create a new pipeline using the nf-core template.                                 │
│ lint           Check pipeline code against nf-core guidelines.                                   │
│ bump-version   Update nf-core pipeline version number with `nf-core pipelines bump-version`.     │
│ sync           Sync a pipeline TEMPLATE branch with the nf-core template.                        │
│ schema         Suite of tools for developers to manage pipeline schema.                          │
│ rocrate        Make an Research Object Crate                                                     │
│ create-logo    Generate a logo with the nf-core logo template.                                   │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────────────────────────╮
│ --help  -h    Show this message and exit.                                                        │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
```

As you can see, there are a number of commands for you to choose from. For this episode, we'll be focusing on the user commands.

To get a list of nf-core pipelines, we need to use the `pipelines` command with the `list` option:

```

                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.2.0 - https://nf-co.re


┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┓
┃ Pipeline Name             ┃ Stars ┃ Latest Release ┃        Released ┃ Last Pulled ┃ Have latest release? ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━╇━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┩
│ deepmodeloptim            │    27 │            dev │ from the future │           - │ -                    │
│ reportho                  │    10 │          1.0.1 │    8 months ago │           - │ -                    │
│ bacass                    │    69 │          2.4.0 │    4 months ago │           - │ -                    │
│ crisprseq                 │    41 │          2.3.0 │    5 months ago │           - │ -                    │
│ seqinspector              │    10 │            dev │     an hour ago │           - │ -                    │
│ multiplesequencealign     │    29 │          1.1.0 │    1 months ago │           - │ -                    │
│ variantbenchmarking       │    26 │          1.1.0 │     3 weeks ago │           - │ -                    │
│ scrnaseq                  │   259 │          4.0.0 │     2 weeks ago │           - │ -                    │
│ rnafusion                 │   150 │          3.0.2 │   12 months ago │           - │ -                    │
│ proteinfold               │    77 │          1.1.1 │    8 months ago │           - │ -                    │
│ bactmap                   │    53 │          1.0.0 │     4 years ago │           - │ -                    │
│ fastquorum                │    21 │          1.1.0 │    4 months ago │           - │ -                    │
│ meerpipe                  │     7 │            dev │    14 hours ago │           - │ -                    │
│ ampliseq                  │   194 │         2.12.0 │    4 months ago │           - │ -                    │
│ lncpipe                   │    33 │            dev │    17 hours ago │           - │ -                    │
│ proteinannotator          │     1 │            dev │    18 hours ago │           - │ -                    │
│ mag                       │   229 │          3.3.1 │    1 months ago │           - │ -                    │
│ eager                     │   160 │          2.5.3 │     1 weeks ago │           - │ -                    │
│ sammyseq                  │     2 │            dev │    19 hours ago │           - │ -                    │
│ metatdenovo               │    28 │          1.1.1 │     2 weeks ago │           - │ -                    │
│ genomeqc                  │     8 │            dev │    20 hours ago │           - │ -                    │
│ funcscan                  │    80 │          2.1.0 │     3 weeks ago │           - │ -                    │
│ fastqrepair               │     3 │          1.0.0 │    2 months ago │           - │ -                    │
│ airrflow                  │    58 │          4.2.0 │    4 months ago │           - │ -                    │
│ proteinfamilies           │    12 │          1.0.0 │    2 months ago │           - │ -                    │
│ riboseq                   │    12 │          1.1.0 │    2 months ago │           - │ -                    │
│ rnaseq                    │  1004 │         3.18.0 │    3 months ago │           - │ -                    │
│ raredisease               │    97 │          2.4.0 │     4 weeks ago │           - │ -                    │
│ hlatyping                 │    64 │          2.0.0 │     2 years ago │           - │ -                    │
│ demo                      │     3 │          1.0.1 │    5 months ago │           - │ -                    │
│ createtaxdb               │     8 │            dev │       yesterday │           - │ -                    │
│ demultiplex               │    45 │          1.6.0 │    1 months ago │           - │ -                    │
│ methylseq                 │   160 │          3.0.0 │    3 months ago │           - │ -                    │
│ epitopeprediction         │    42 │          2.3.1 │   10 months ago │           - │ -                    │
│ viralrecon                │   133 │          2.6.0 │     2 years ago │           - │ -                    │
│ molkart                   │    11 │          1.1.0 │     3 weeks ago │           - │ -                    │
│ spatialxe                 │    13 │            dev │       yesterday │           - │ -                    │
│ genomeassembler           │    21 │          1.0.1 │     1 weeks ago │           - │ -                    │
│ coproid                   │     9 │          1.1.1 │     2 years ago │           - │ -                    │
│ sarek                     │   434 │          3.5.1 │    1 months ago │           - │ -                    │
│ pacvar                    │     8 │          1.0.1 │     3 weeks ago │           - │ -                    │
│ lsmquant                  │     0 │            dev │      2 days ago │           - │ -                    │
│ references                │    12 │            0.1 │    3 months ago │           - │ -                    │
│ rnavar                    │    45 │          1.0.0 │     3 years ago │           - │ -                    │
│ pathogensurveillance      │    20 │            dev │     1 weeks ago │           - │ -                    │
│ scnanoseq                 │    25 │          1.1.0 │     1 weeks ago │           - │ -                    │
│ mhcquant                  │    33 │          2.6.0 │    9 months ago │           - │ -                    │
│ spatialvi                 │    59 │            dev │     2 weeks ago │           - │ -                    │
│ taxprofiler               │   139 │          1.2.3 │     2 weeks ago │           - │ -                    │
│ tfactivity                │    10 │            dev │     2 weeks ago │           - │ -                    │
│ chipseq                   │   208 │          2.1.0 │    6 months ago │           - │ -                    │
│ oncoanalyser              │    62 │          1.0.0 │    7 months ago │           - │ -                    │
│ isoseq                    │    38 │          2.0.0 │    7 months ago │           - │ -                    │
│ mcmicro                   │    13 │            dev │     2 weeks ago │           - │ -                    │
│ magmap                    │     5 │            dev │     2 weeks ago │           - │ -                    │
│ differentialabundance     │    75 │          1.5.0 │   11 months ago │           - │ -                    │
│ circrna                   │    52 │            dev │     3 weeks ago │           - │ -                    │
│ rangeland                 │     6 │          1.0.0 │    2 months ago │           - │ -                    │
│ phaseimpute               │    19 │          1.0.0 │    4 months ago │           - │ -                    │
│ methylarray               │     3 │            dev │     3 weeks ago │           - │ -                    │
│ smrnaseq                  │    80 │          2.4.0 │    5 months ago │           - │ -                    │
│ drugresponseeval          │     6 │          1.0.0 │    2 months ago │           - │ -                    │
│ phyloplace                │     9 │          2.0.0 │    1 months ago │           - │ -                    │
│ atacseq                   │   198 │          2.1.2 │     2 years ago │           - │ -                    │
│ mitodetect                │     6 │            dev │    1 months ago │           - │ -                    │
│ pangenome                 │    85 │          1.1.3 │    2 months ago │           - │ -                    │
│ methylong                 │     1 │            dev │    2 months ago │           - │ -                    │
│ pairgenomealign           │     7 │          2.0.0 │    2 months ago │           - │ -                    │
│ troughgraph               │     2 │            dev │    2 months ago │           - │ -                    │
│ denovotranscript          │    14 │          1.2.0 │    2 months ago │           - │ -                    │
│ tumourevo                 │    12 │            dev │    2 months ago │           - │ -                    │
│ evexplorer                │     0 │            dev │    2 months ago │           - │ -                    │
│ nanostring                │    13 │          1.3.1 │    2 months ago │           - │ -                    │
│ dualrnaseq                │    21 │          1.0.0 │     4 years ago │           - │ -                    │
│ pixelator                 │     8 │          1.4.0 │    2 months ago │           - │ -                    │
│ scdownstream              │    53 │            dev │    2 months ago │           - │ -                    │
│ fetchngs                  │   172 │         1.12.0 │     1 years ago │           - │ -                    │
│ diaproteomics             │    17 │          1.2.4 │     4 years ago │           - │ -                    │
│ kmermaid                  │    20 │    0.1.0-alpha │     4 years ago │           - │ -                    │
│ stableexpression          │     3 │            dev │    3 months ago │           - │ -                    │
│ nascent                   │    18 │          2.2.0 │     1 years ago │           - │ -                    │
│ marsseq                   │     6 │          1.0.3 │     2 years ago │           - │ -                    │
│ datasync                  │     8 │            dev │    4 months ago │           - │ -                    │
│ rnasplice                 │    52 │          1.0.4 │   11 months ago │           - │ -                    │
│ metapep                   │    11 │          1.0.0 │    4 months ago │           - │ -                    │
│ radseq                    │     6 │            dev │    4 months ago │           - │ -                    │
│ createpanelrefs           │     8 │            dev │    4 months ago │           - │ -                    │
│ detaxizer                 │    14 │          1.1.0 │    5 months ago │           - │ -                    │
│ tbanalyzer                │     8 │            dev │    5 months ago │           - │ -                    │
│ bamtofastq                │    24 │          2.1.1 │   11 months ago │           - │ -                    │
│ rnadnavar                 │     7 │            dev │    8 months ago │           - │ -                    │
│ hic                       │    96 │          2.1.0 │     2 years ago │           - │ -                    │
│ callingcards              │     4 │          1.0.0 │   10 months ago │           - │ -                    │
│ metaboigniter             │    19 │          2.0.1 │   12 months ago │           - │ -                    │
│ viralintegration          │    17 │          0.1.1 │     2 years ago │           - │ -                    │
│ readsimulator             │    29 │          1.0.1 │   11 months ago │           - │ -                    │
│ phageannotator            │    12 │            dev │   11 months ago │           - │ -                    │
│ drop                      │     2 │            dev │   12 months ago │           - │ -                    │
│ spinningjenny             │     3 │            dev │   12 months ago │           - │ -                    │
│ omicsgenetraitassociation │    10 │            dev │     1 years ago │           - │ -                    │
│ circdna                   │    28 │          1.1.0 │     1 years ago │           - │ -                    │
│ cutandrun                 │    89 │          3.2.2 │     1 years ago │           - │ -                    │
│ nanoseq                   │   194 │          3.1.0 │     2 years ago │           - │ -                    │
│ hicar                     │     8 │          1.0.0 │     3 years ago │           - │ -                    │
│ gwas                      │    24 │            dev │     2 years ago │           - │ -                    │
│ hgtseq                    │    25 │          1.1.0 │     2 years ago │           - │ -                    │
│ variantcatalogue          │    11 │            dev │     2 years ago │           - │ -                    │
│ clipseq                   │    21 │          1.0.0 │     4 years ago │           - │ -                    │
│ genomeskim                │     3 │            dev │     3 years ago │           - │ -                    │
│ imcyto                    │    25 │          1.0.0 │     5 years ago │           - │ -                    │
│ mnaseseq                  │    11 │          1.0.0 │     3 years ago │           - │ -                    │
│ genomeannotator           │    27 │            dev │     3 years ago │           - │ -                    │
│ proteomicslfq             │    33 │          1.0.0 │     4 years ago │           - │ -                    │
│ cageseq                   │    11 │          1.0.2 │     4 years ago │           - │ -                    │
│ pgdb                      │     6 │          1.0.0 │     4 years ago │           - │ -                    │
│ slamseq                   │     8 │          1.0.0 │     5 years ago │           - │ -                    │
└───────────────────────────┴───────┴────────────────┴─────────────────┴─────────────┴──────────────────────┘
```
Besides listing the names of available pipelines, the output of this command tells you what pipelines you have downloaded and if you have the most recent version downloaded.

To use a specific pipeline, we must download it using the `Nextflow pull` command, which is a Nextflow command, not an nf-core command.

```
nextflow pull nf-core/demo
```

Running `nf-core pipelines list` again, we'll see that the list entry for demo has been updated to show that we've downloaded the demo pipeline.

## Running nf-core pipelines

Now that we've downloaded the demo pipeline, we can use Nextflow's `run` command to start the pipeline, and we use the `-r` flag to indicate which version of the pipeline we want to use:

```
nextflow run nf-core/demo -r 1.0.1
``` 

Since we tried to run the pipeline without any parameters, we get the following error:

```
ERROR ~ Validation of pipeline parameters failed!

 -- Check '.nextflow.log' file for details
The following invalid input values have been detected:

* Missing required parameter(s): input, outdir
```

This error tells us we're missing the `input` and `outdir` parameters.

Instead of giving the demo pipeline input with the `input` parameter, we're going to use something called a test profile to run the pipeline. Nextflow [profiles](https://www.nextflow.io/docs/latest/config.html#config-profiles) contain settings that tell Nextflow how you want to run the pipeline. These settings are set in a configuration file.

All nf-core pipelines come with a test profile that includes settings that test if the pipeline is working correctly. Datasets for testing the pipeline are also included. The test profile tells Nextflow we want to use the test dataset as input, so we don't have to specify an input parameter. We still need to tell Nextflow where we want the results to go using the `output` parameter. To run demo with the test profile, use the following command:

```
nextflow run nf-core/demo -r 1.0.1 -profile docker,test --outdir results
```

The `-profile` parameter tells Nextflow what profile we want to use. In this case, we used the Docker and test options. This runs the pipeline with Docker using the test configuration.

Once the pipeline has finished, we can explore the output in the `results` directory. The outputs from each step in the pipeline are stored in a directory named after that step. Information about the pipeline's execution can be found in the `pipeline_info` directory.

```
ls results/
```

The results directory should have the following structure:

```
├── fastqc
│   ├── SAMPLE1_PE
│   ├── SAMPLE2_PE
│   └── SAMPLE3_SE
├── fq
│   ├── SAMPLE1_PE
│   ├── SAMPLE2_PE
│   └── SAMPLE3_SE
├── multiqc
│   ├── multiqc_data
│   ├── multiqc_plots
│   └── multiqc_report.html
└── pipeline_info
    ├── execution_report_*.html
    ├── execution_timeline_*.html
    ├── execution_trace_*.txt
    ├── nf_core_pipeline_software_mqc_versions.yml
    ├── params_*.json
    └── pipeline_dag_*.html
```

Now that you know how to run nf-core pipelines, in the next episode we'll learn how to make your own custom pipeline.

#### Challenge 1

What two commands would you use to:
1. Download the nf-core pipeline [viralrecon v2.6.0](https://nf-co.re/viralrecon/2.6.0/)?
2. Test the nf-core pipeline [viralrecon v2.6.0](https://nf-co.re/viralrecon/2.6.0/) using the test profile?

The solution to this challenge can be found [here](/nf-core/challenge-solutions/running-pipelines/challenge-1.md).

## Key points
1. Ready-to-use nf-core pipelines can be found on nf-core's website or by using nf-core tools `pipelines` command with the `list` option.
2. After downloading an nf-core pipeline using `nextflow pull`, you can test them using the `nextflow run` command with their `test` profile.
3. A profile is a configuration file that contains settings that tell Nextflow how you want to run the pipeline.
