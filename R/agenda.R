library(tibble)

agenda <- frame_matrix(
  ~Time, ~Topic,
   '09:00', '[R basics](R_basics.qmd)',
   '10:00', 'Break',
   '10:15', '[Data wrangling part 1](data_wrangling_1.qmd)',
   '11:15', 'Break',
   '11:30', '[Data wrangling part 2](data_wrangling_2.qmd)',
   '12:30', 'Lunch',
   '1:30', '[Data viz](data_viz.qmd)',
   '2:30', 'Break',
   '2:45', '[Spatial data analysis](spatial_data_analysis.qmd)',
   '3:45', 'Continued learning and adjourn'
)

save(agenda, file = 'data/agenda.RData')
