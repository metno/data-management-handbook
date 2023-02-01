#!/bin/bash

set -ve

DMH_FOLDER_GENERAL="data-management-handbook"
DMH_GENERAL=${DMH_GENERAL:-https://github.com/metno/data-management-handbook}

DMH_GENERAL_VERSION=${DMH_GENERAL_VERSION:-master}

# For local testing, use this:
#DMH_GENERAL_VERSION=<issue-branch> # e.g., issue71_example_metadata

IMAGES_DIR=${IMAGES_DIR:-/workdir/source/images}
PDF_THEMES_DIR=${PDF_THEMES_DIR:-/workdir/source}
RESULTS_HTML=${RESULTS_HTML:-/workdir/html}
RESULTS_PDF=${RESULTS_PDF:-/workdir/pdf}

SPECIAL_APPENDIX_USERS=${SPECIAL_APPENDIX_USERS:-/workdir/source/specialized_appendix_users.adoc}
TITLE_PAGE=${TITLE_PAGE:-/workdir/source/title_page.adoc}
SPECIAL_INTRO=${SPECIAL_INTRO:-/workdir/source/specialized_intro_MET.adoc}
SPECIAL_STRUDOC=${SPECIAL_STRUDOC:-/workdir/source/specialized_strudoc_MET.adoc}
SPECIAL_DATA_SERVICES=${SPECIAL_DATA_SERVICES:-/workdir/source/specialized_data_services_MET.adoc}
SPECIAL_USER_PORTALS=${SPECIAL_USER_PORTALS:-/workdir/source/specialized_userportals_MET.adoc}
SPECIAL_DATA_GOVERNANCE=${SPECIAL_DATA_GOVERNANCE:-/workdir/source/specialized_datagov_MET.adoc}
SPECIAL_PRACTICAL_GUIDANCE=${SPECIAL_PRACTICAL_GUIDANCE:-/workdir/source/specialized_practical_guidance_MET.adoc}
SPEC_DEFAULT_GLOBAL_ATTRS=${SPEC_DEFAULT_GLOBAL_ATTRS:-/workdir/source/spec_default_global_attrs_MET.adoc}

CWD=$(pwd)
#the following line solves "fatal: detected dubious ownership in 
# repository at '/workdir/data-management-handbook'":
#git config --global --add safe.directory '*'
if [ -d "${DMH_FOLDER_GENERAL}" ]; then
  echo "$DMH_FOLDER_GENERAL repository exists locally, running git pull"
  cd $DMH_FOLDER_GENERAL
  git pull
else
  echo "Cloning $DMH_GENERAL"
  git clone $DMH_GENERAL
  cd $DMH_FOLDER_GENERAL
  git checkout $DMH_GENERAL_VERSION
fi
GENERAL_DMH_DIR=$(pwd)

cd $CWD

cp $DMH_FOLDER_GENERAL/source/images/*.png $IMAGES_DIR

asciidoctor -r asciidoctor-diagram \
      -a title_page=$TITLE_PAGE \
      -a special_intro=$SPECIAL_INTRO \
      -a special_strudoc=$SPECIAL_STRUDOC \
      -a special_data_services=$SPECIAL_DATA_SERVICES \
      -a special_user_portals=$SPECIAL_USER_PORTALS \
      -a special_data_governance=$SPECIAL_DATA_GOVERNANCE \
      -a special_practical_guidance=$SPECIAL_PRACTICAL_GUIDANCE \
      -a spec_default_global_attrs=$SPEC_DEFAULT_GLOBAL_ATTRS \
      -a special_appendix_users=$SPECIAL_APPENDIX_USERS \
      -a toc=left \
      -a imagesdir=$IMAGES_DIR \
      -a data-uri=Yes \
      -n $DMH_FOLDER_GENERAL/source/data-management-handbook.adoc \
      -D $RESULTS_HTML
  
asciidoctor-pdf -r asciidoctor-diagram \
      -a pdf-themesdir=$PDF_THEMES_DIR \
      -a pdf-theme=dmh \
      -a title_page=$TITLE_PAGE \
      -a special_intro=$SPECIAL_INTRO \
      -a special_strudoc=$SPECIAL_STRUDOC \
      -a special_data_services=$SPECIAL_DATA_SERVICES \
      -a special_user_portals=$SPECIAL_USER_PORTALS \
      -a special_data_governance=$SPECIAL_DATA_GOVERNANCE \
      -a special_practical_guidance=$SPECIAL_PRACTICAL_GUIDANCE \
      -a spec_default_global_attrs=$SPEC_DEFAULT_GLOBAL_ATTRS \
      -a special_appendix_users=$SPECIAL_APPENDIX_USERS \
      -a imagesdir=$IMAGES_DIR \
      -n $DMH_FOLDER_GENERAL/source/data-management-handbook.adoc \
      -D $RESULTS_PDF
cd ..
