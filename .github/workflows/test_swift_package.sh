
#!/bin/bash

set -eo pipefail

cd Biern; swift test --parallel; cd ..
