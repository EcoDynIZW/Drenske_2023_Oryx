## Render your scripts to html
## Render all .Rmd files placed in ./R
d6::render_all_reports()
## Or render each step by step
## Add additonal lines for each .Rmd file placed in ./R that you want to render
#d6::render_report("myRMD.Rmd")

#d6::render_report("01_Demography_data_preparation.Rmd")
#d6::render_report("02_Demography_data_exploration.Rmd")

####d6::render_report("03_Study_area.Rmd")
####d6::render_report("04_Demography_survival_analysis.Rmd") # hier werden verschiedene Objekte immer wieder nicht gefunden. Aber sie sind im Code... Wenn ich ihn durchlaufen lasse, funktioniert auch alles

#d6::render_report("05a_Demography_reproduction_analysis.Rmd")
#d6::render_report("05b_Demography_reproduction_analysis_GLMM.Rmd")

####d6::render_report("06a_PVA_Management_Improvement_data_preparation.Rmd") # findet Spalten nicht, wenn ich selbst ausführe geht es aber

#d6::render_report("06b_PVA_Management_Improvement_analysis.Rmd")
#d6::render_report("06c_PVA_Management_Improvement_plots.Rmd")
#d6::render_report("07a_PVA_Stochastic_Events_data_preparation.Rmd") # wieso geht es hier, aber nicht bei 6a?
####d6::render_report("07b_PVA_Stochastic_Events_analysis.Rmd") # findet Lambda_sto nicht mehr...
#d6::render_report("07c_PVA_Stochastic_Events_plots.Rmd")
#d6::render_report("08_PVA_GLM.Rmd")

## Build Dockerfile
#devtools::install_github("karthik/holepunch")
holepunch::write_dockerfile()
