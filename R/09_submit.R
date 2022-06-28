## Render your scripts to html
## Render all .Rmd files placed in ./R
#d6::render_all_reports()
## Or render each step by step
## Add additonal lines for each .Rmd file placed in ./R that you want to render
#d6::render_report("myRMD.Rmd")

#d6::render_report("01_Demography_data_preparation.Rmd")
#d6::render_report("02_Demography_data_exploration.Rmd")

####d6::render_report("03_Study_area.Rmd") # too complex to create a report
####d6::render_report("04_Demography_survival_analysis.Rmd") # Report cannot be created because various variables are repeatedly not found. If the script is run manually, everything works.

#d6::render_report("05a_Demography_reproduction_analysis.Rmd")
#d6::render_report("05b_Demography_reproduction_analysis_GLMM.Rmd")

####d6::render_report("06a_PVA_Management_Improvement_data_preparation.Rmd") # Report cannot be created because various columns are repeatedly not found. If the script is run manually, everything works.


#d6::render_report("06b_PVA_Management_Improvement_analysis.Rmd")
#d6::render_report("06c_PVA_Management_Improvement_plots.Rmd")
#d6::render_report("07a_PVA_Stochastic_Events_data_preparation.Rmd")
####d6::render_report("07b_PVA_Stochastic_Events_analysis.Rmd") # Report cannot be created because a variable (Lambda_sto) is not found. If the script is run manually, everything works.
#d6::render_report("07c_PVA_Stochastic_Events_plots.Rmd")
#d6::render_report("08_PVA_GLM.Rmd")

## Build Dockerfile
# devtools::install_github("karthik/holepunch")
# holepunch::write_compendium_description()
# holepunch::write_dockerfile()









