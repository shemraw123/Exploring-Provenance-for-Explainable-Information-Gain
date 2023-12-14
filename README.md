# Exploring-Provenance-for-Explainable-Information-Gain

Link to repo for implementation : https://github.com/shemraw/gprom_IG

# Overview

In recent years, a large amount of data is collected
from multiple sources and the demands for analyzing these data
have increased enormously. Data sharing is a valuable part of
this data-intensive and collaborative environment due to the
synergies and added values created by multi-modal datasets
generated from different sources. In this work, we introduce a
technique that quantifies the degree of information gain (IG) that
is obtained over data sharing. The IG is computed based on the
distance between data that are integrated after the sharing. Our
method captures both where (to compute the IG over values)
and how provenance (to find matching records) and accurately
computes the IG based on them. To provide better understanding
on the data sharing, we develop a technique that computes
meaningful summaries of data that highly contribute to IG. For
that, we define four metrics that allow to provide such meaningful
explanations. We conduct a set of experiments to demonstrate the
performance and accuracy of our approach comparing to naive
method using real-world datasets

# Features

Gives us rewritten query and all the new pattern and their calculated degree of new information(IG) and ranking of patterns according to fscore. Fscore uses informativeness, coverage, impact and corr to rank the patterns.

# Usage #

Example of Input query : ./scripts/dev/debug_gprom.sh 3 "IG OF(Select * from owned o JOIN shared s ON(o.county = s.county));"

# Installation

The [wiki](https://github.com/IITDBGroup/gprom/wiki/installation) has detailed installation instructions. In a nutshell, GProM can be compiled with support for different database backends and is linked against the C client libraries of these database backends. The installation follows the standard procedure using GNU build tools. Checkout the git repository, install all dependencies and run:

```
./autogen.sh
./configure
make
sudo make install
```

# Research and Background

The functionality of GProM is based on a long term research effort by the [IIT DBGroup](http://www.cs.iit.edu/~dbgroup/) studying how to capture provenance on-demand using instrumentation. Links to [publications](http://www.cs.iit.edu/~dbgroup/publications) and more research oriented descriptions of the techniques implemented in GProM can be found at [http://www.cs.iit.edu/~dbgroup/research](http://www.cs.iit.edu/~dbgroup/research).

