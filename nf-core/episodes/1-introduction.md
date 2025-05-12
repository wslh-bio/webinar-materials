# Getting started with nf-core
| Questions  | Objectives |
| ------------- | ------------- |
| What is nf-core?  | Define what nf-core is and explain how it relates to Nextflow. |
| Why should I use the nf-core framework? | List and explain the six main benefits of using nf-core. |

## What is nf-core?
[nf-core](https://nf-co.re/) is a community effort to collect a curated set of analysis pipelines built with the workflow management language [Nextflow](https://www.nextflow.io/docs/latest/index.html). The creators' goal is to provide a framework for high-quality, standardized, and reproducible bioinformatics pipelines that can be used across all institutions and research facilities.

## The core features and key benefits of nf-core

There are six core features of nf-core that are beneficial to bioinformaticians and other computational biologist, whether they be in a government, private sector, or academic setting:

1. **Community**: One major advantage of the nf-core framework is its community, which develops best practices, pipelines, and tools. All code is hosted openly on GitHub, and members actively participate in code reviews and discussions via GitHub and Slack. Both developers and users can participate in improving pipelines. This community-driven approach overcomes the traditional barriers between research groups, allowing for shared expertise and collaborative development.
2. **Guidelines**: The nf-core community has established a set of guidelines that outline the requirements and recommendations for pipeline development. This ensures consistency and adherence to best practices across all workflows. These guidelines require all pipelines to provide thorough documentation, including usage examples and results descriptions. Additionally, test datasets must be included to enable automated continuous-integration testing. This ensures pipeline functionality is maintained with every change.
3. **Portability**: All nf-core pipelines, which must be written in the Nextflow language, inherit portability that allows for execution across local machines and cloud platforms. This surmounts the challenge of creating reproducible analyses across different systems. The nf-core framework enhances this functionality by enforcing consistent implementation practices through templates, guidelines, and lint tests that ensure all pipelines fully utilize these portability features. Additionally, nf-core requires all pipelines to bundle dependencies in Docker containers, providing immutable runtime environments that further enhance portability and reproducibility across different systems. This minimizes issues related to hardware differences, operating systems, and software versions.
4. **Reproducibility**: Once stable, ​nf-core​ pipelines are given tagged releases on GitHub. Each version is given a number using semantic versioning, and nf-core​ pipelines support the collection of analysis metadata such as pipeline version, software versions, and command and parameter configuration.
5. **Standardization**: To help developers get started with new pipelines, nf-core provides a standardized pipeline template that adheres to all nf-core guidelines, as well as command line tools for pipeline creation. This lowers barriers to development and provides consistent structure across all pipelines, making them easier to learn, use, and develop.
7. **Research Impact**: The nf-core framework increases reliability and reproducibility of scientific analyses, and it accelerates scientific discoveries through ready-to-use, validated workflows.
