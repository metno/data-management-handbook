![html/pdf](https://github.com/metno/data-management-handbook/workflows/html/pdf/badge.svg?branch=master)

# Data Management Handbook

Data Management Handbook template for MET and partners in S-ENDA written in asciidoc.

See it [here](https://metno.github.io/data-management-handbook/).

This handbook template is based on the first version of the Data Management Handbook used at the Meteorological Institute in Norway (METNorway). The handbook was rewritten into this template version so that other institutions and partners could use it to create their own data management handbook.

This repo includes only the general parts of the data management handbook that should be universal for all partners, and templates for the chapters that include partner specific information. 

In case of questions and need for help - please submit an issue on this repository!

## How to use this handbook:

 * Create a separate repo in Github or Gitlab, (If the data management handbook will include detailed information about IT systems, secrets or other information that should not be available outside of your organization, a private repository is recommended)
   
   * doc folder: Add only the templates for the chapters and appendices that includes partner specific information (all starting with specialized):
   
	* specialized_intro_template.adoc
	* specialized_data_services_template.adoc
	* specialized_datagov_template.adoc
	* specialized_strudoc_template.adoc
	* specialized_userportals_template.adoc
	* specialized_practical_guidance_template.adoc
	* specialized_appendixB_template.adoc
	* To get your organisations visual profile on the DMH, create or add a .yml file with the theme for the handbook.

The file “data-management-handbook.adoc”, includes the specialized files via variables. These variables are defined in the docker-compose.asciidoctor.yml file. (If one of the partner-specific files does not exist in your local repository, The CI will add the template). This is also the file that sets up the pdf.

## Compiling the documentation
The general part of the documentation can be compiled by running `vagrant up`. You can reuse the code here to add CI and compile your own version. Please ask if you need help.

## Other information
The docker-compose.acdd_elements.yml creates the acdd file via CI. This appendix is relevant for all partners that use NetCDf- files.
