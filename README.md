![html/pdf](https://github.com/metno/data-management-handbook/workflows/html/pdf/badge.svg?branch=master)

# Data Management Handbook

Data Management Handbook template for MET and partners in S-ENDA written in asciidoc.

See it [here](https://metno.github.io/data-management-handbook/).

This handbook template is based on the first version of the Data Management Handbook used at the Meteorological Institute in Norway (METNorway). The handbook was rewritten into this template version so that other institutions and partners could use it to create their own data management handbook.

This repo includes only the general parts of the data management handbook that should be universal for all partners, and templates for the chapters that include partner specific information. 

In case of questions and need for help - please submit an issue on this repository!

# Local compilation of the handbook

The general part of the documentation can be compiled by running `vagrant up`. You can reuse the code here to add CI and compile your own version.

Please ask if you need help.

# How to reuse and customize this handbook

 1. Create a separate (new) git repository (a private repository is recommended; it could be both gitlab or github);
 2. Create a folder named, e.g., "source" in your new repository;
    * Copy all the template files containing the string `specialized` or just `spec` from the generic version (this one) to the new folder; and
    * Copy the file `dmh-theme.yml` to the new folder.
 3. To get your organisation's visual profile on the DMH, replace the content of `dmh-theme.yml` to reflect your organisation;
 4. Copy the content of `custom-setup` into the root folder of your new repository;
 5. Set up CI/CD
    a. Gitlab:
       * Change the filename `dot.gitlab-ci.yml` to `.gitlab-ci.yml` (linux: `mv dot.gitlab-ci.yml .gitlab-ci.yml`)
       * Make sure that the following environment variables are defined under the variables entry under build-docs in `.gitlab-ci.yml` (note that `$CI_PROJECT_DIR` should be provided through the gitlab CI system):
       ```
       DMH_GENERAL: https://github.com/metno/data-management-handbook
       DMH_GENERAL_VERSION: master
       IMAGES_DIR: $CI_PROJECT_DIR/source/images
       PDF_THEMES_DIR: $CI_PROJECT_DIR/source
       SPECIAL_APPENDIX_USERS: $CI_PROJECT_DIR/source/specialized_appendix_users.adoc
       TITLE_PAGE: $CI_PROJECT_DIR/source/title_page.adoc
       SPECIAL_INTRO: $CI_PROJECT_DIR/source/specialized_intro_MET.adoc
       SPECIAL_STRUDOC: $CI_PROJECT_DIR/source/specialized_strudoc_MET.adoc
       SPECIAL_DATA_SERVICES: $CI_PROJECT_DIR/source/specialized_data_services_MET.adoc
       SPECIAL_USER_PORTALS: $CI_PROJECT_DIR/source/specialized_userportals_MET.adoc
       SPECIAL_DATA_GOVERNANCE: $CI_PROJECT_DIR/source/specialized_datagov_MET.adoc
       SPECIAL_PRACTICAL_GUIDANCE: $CI_PROJECT_DIR/source/specialized_practical_guidance_MET.adoc
       SPEC_DEFAULT_GLOBAL_ATTRS: $CI_PROJECT_DIR/source/spec_default_global_attrs_MET.adoc
       ```

     b. Github: this is not yet implemented but should be somehow similar..

 6. For compilation on your local computer:

  * Install [vagrant](https://developer.hashicorp.com/vagrant/downloads);
  * Install [virtualbox](https://www.virtualbox.org/);
  * Uncomment line no. 31 in `compile-docs.sh` and avoid committing it back to git;
  * Make sure the file paths specified for the environment variables in `compile-docs.sh` (e.g., `TITLE_PAGE=${TITLE_PAGE:-/workdir/source/title_page.adoc}`, where the file path is `/workdir/source/title_page.adoc`) are correct and according to the ones defined in point 2 above (they should be if this description is strictly followed);
  * run `vagrant up` (`Vagrantfile` defines a virtual machine configuration for easy local compilation of the HTML and PDF versions of the handbook with the command `vagrant up`);
  * The compiled pdf and html documents should now be available in the `pdf/` and `html/` subfolders.
  * NOTE: make sure that you DO NOT commit and push `source/acdd-elements.adoc`, `pdf/data-management-handbook.pdf` or `html/data-management-handbook.html` back to you (new) repository, as this will cause conflicts with the CI/CD committed files (we intend to improve the code to avoid this problem but it is not high priority).

More explanation:

Upon compilation, the file `source/data-management-handbook.adoc`, which resides here (i.e., in this general repository), will include the custom files via environment variables. These variables must be defined in you CI system (if one of the partner-specific files does not exist in your local repository, the template provided here will be used).

To simplify the process, the MET gitlab CI files are copied into the folder `custom-setup` of the current repository:

* `dot.gitlab-ci.yml` (change the name to `.gitlab-ci.yml`) is used for compiling HTML and PDF versions of the MET customized handbook. Environment variables used in Gitlab CI are defined there. Modify the paths to match your own system.
* `Vagrantfile` defines a virtual machine configuration for easy local compilation of the HTML and PDF versions of the handbook with the command `vagrant up`;

  * `docker-compose.acdd_elements.yml` is used to build the `Dockerfile.acdd_elements` container to run the `yaml2adoc.py` script from [py-mmd-tools](https://github.com/metno/py-mmd-tools) and create an asciidoc file describing how to document netcdf-cf files with global attributes. Do not change the file created by this script (`source/acdd-elements.adoc`), since that will cause git conflicts.
  * `docker-compose.asciidoctor.yml` is used to build the `Dockerfile.asciidoctor` container to run the `compile-docs.sh` script, and create the HTML and PDF versions of the handbook.
  * NOTE: when running `vagrant up`, you will have to uncomment line no. 31 in `compile-docs.sh` and avoid committing it back to git.

* `compile-docs.sh` contains alternative paths to the ones used in `.gitlab-ci.yml`, which are used in the vagrant and docker-compose setup. The CI system will override these paths. The filenames should reflect the ones you defined in point 2 above.
