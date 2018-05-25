#install.packages("devtools")
library(devtools)
install_github("nhemerson/tibbleColumns")
library(tidyverse)
library(tibbleColumns)

#prop_column_group
mtcars %>% prop_column_group(cyl)

#prop_column
mtcars %>% count(cyl, mpg) %>% prop_column(n)

#change_XoX_column
tc <- tibble(
  Month = c("Jan", "Dec"),
  Users = c(102, 909)
)

tc %>% spread(Month, Users) %>% change_XoX_column(Dec, Jan, "MoM")

#change_XoX_column_group
tcg <- tibble(
  Month = c("Jan", "Jan","Dec", "Dec"),
  Type = c("Red", "Blue", "Red", "Blue"),
  Users = c(102, 909, 201, 479)
)

tcg %>% select(Type, Month, Users) %>% change_XoX_column_group(Dec, Jan, "MoM")

#testoutput
t1 <- tibble(
    type = c("Blue", "Blue", "Blue", "Blue"),
    num = runif(4,0,5)
  )

t2 <- tibble(
  type = c("Red","Red", "Red", "Red"),
  num = runif(4,0,5)
)

ttest_tibble(t1$num,t2$num)


#lm output
mtcars %>% select(mpg,cyl,wt) %>% lm_summary_tibble(mpg)


#replace all NA

#data with NAs
mtcars %>% 
tbl_out("cars") %>% 
count(cyl,vs) %>% 
spread(cyl,n)
 
#replace the NAs
mtcars %>% 
tbl_out("cars") %>% 
count(cyl,vs) %>% 
spread(cyl,n) %>% 
replace_all_na()


#tbl_module
mtcars %>% tbl_out("cars") %>% tbl_module(filter(.,hp > 150), "fastCars") %>% tbl_lookup(cyl) %>% tbl_out("cylList")

#tbl_module date example
dateEx <- data_frame(date = c(Sys.Date(),Sys.Date() - 1,Sys.Date() - 3), num = rnorm(3))
dateEx %>% separate(date, into = c("year","month","day"))

dateEx %>% 
tbl_module(select(.,date),"dateCol") %>%
separate(date, into = c("year","month","day")) %>%
bind_cols(dateCol,.)

#block coding
mtcars %>% rownames_to_column() %>% rename(Name = rowname) %>% tbl_out("cars") %>% select(cyl,hp,mpg) %>% tbl_out("cars1") %>% mutate(Calc = hp/mpg) %>% round(0) %>% tbl_out("roundOut") %>% lm_summary_tibble("mpg") %>% tbl_out("lmOut")

#bool to binary
iris %>% mutate(Setosa = str_detect(.$Species, "setosa")) %>% bool_to_binary(.,Setosa)
