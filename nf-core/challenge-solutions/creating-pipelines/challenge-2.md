## Solution:

#### Answer 1
```
nf-core modules install fastqc
```

#### Answer 2
```
include { FASTQC             } from '../modules/nf-core/fastqc/main'
```

#### Answer 3
```
FASTQC(reads_ch)
```
