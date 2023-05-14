# gradesnda23
Random model generator used for the GRADES-NDA'23 Paper, as well a single contact point for the competing approaches

## Model Generator

The Python scripts provided in ```convert_same``` provide a Python script for generating models for both KnoBAB, MINERful, and MP Declare.
The pipeline consists of the following configuration files:

 * ```data.yaml```: specifies the paths associated to the algorithm to be run, the paths where their scripts are located, the maximium and minimum size for the trace length and log size, and the number of times to run the experiments
 * ```alignment.csv```: the alignment between the different names across the generators for the same declarative clauses. 
 * ```test_model.txt```: the configuration of the model which syntax is defined in Antlr4 (```scratch.g4```)

## Competing Approaches

All the competing approaches, as well as the version of KnoBAB containing the data generator, are available in the ```competitors``` folder. The README for the proposed approach is provided in the [GitHub](https://github.com/datagram-db/knobab/tree/d99ecb135ef9a6ab774bf84da0ece1f93afbc335) branch of interest.
