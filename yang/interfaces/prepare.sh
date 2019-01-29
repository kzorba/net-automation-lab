#!/bin/bash
#
# Prepares everything required to run gen-interfaces-pillar.py
# Generates binding.py needed by pyangbind and creates informational
# tree represantations of the relevant Openconfig models
#
SDIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYBINDPLUGIN=`/usr/bin/env python -c 'import pyangbind; import os; print ("{}/plugin".format(os.path.dirname(pyangbind.__file__)))'`
OC_MODELS_DIR="$SDIR/../public/release/models/"

echo "Generating pyang bindings for interfaces..."
pyang --plugindir $PYBINDPLUGIN -f pybind -p ${OC_MODELS_DIR} -o $SDIR/binding.py ${OC_MODELS_DIR}/interfaces/openconfig-interfaces.yang ${OC_MODELS_DIR}/interfaces/openconfig-if-ip.yang
echo "Bindings successfully generated!"
echo "Generating text tree representation of interfaces model"
pyang -f tree -p ${OC_MODELS_DIR} ${OC_MODELS_DIR}/interfaces/openconfig-interfaces.yang ${OC_MODELS_DIR}/interfaces/openconfig-if-ip.yang > openconfig-if-ip.txt
echo "Generating html tree representation of interfaces model"
pyang -f jstree -p ${OC_MODELS_DIR} ${OC_MODELS_DIR}/interfaces/openconfig-interfaces.yang ${OC_MODELS_DIR}/interfaces/openconfig-if-ip.yang > openconfig-if-ip.html
echo "------------------------------------------------"
echo "Done. You can now use gen-interfaces-pillar.py. "
echo "Model representations are in                    " 
echo "openconfig-if-ip.txt, openconfig-if-ip.html     "
echo "------------------------------------------------"
