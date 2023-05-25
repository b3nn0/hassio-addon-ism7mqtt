Bump ism7mqtt to v0.0.12

## What's Changed

- added German translation for add-on configuration
- fix output of BinaryReadOnlyConverterTemplate, MicerStateConverterTemplate and corresponding ha discovery topics by @zivillian in #60

## Breaking Change
- Boolean parameters are no longer as true/false but instead as 0/1 and the corresponding text value
- Mixer state value is no longer reported as -/closed/opened, but as 0/1/2 and the corresponding text value
