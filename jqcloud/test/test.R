source('../R/jQCloud.R')
dat <- list(
  list(text='Lorem', weight=15),
  list(text='Ipsum', weight=9, link='http://jquery.com/'),
  list(text='Dolor', weight=6, html=list(title='I can have any html attribute')),
  list(text='Sit', weight=7),
  list(text='Amet', weight=5)
)
a <- jQCloud$new()
a$data(dat)
a$height(400)
a$width(400)
print(a)
