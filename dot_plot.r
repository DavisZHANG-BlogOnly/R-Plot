# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script: 

# dataset <- data.frame(STEP, TEAM, END, START)
# dataset <- unique(dataset)

# Paste or type your script code here:
library(ggplot2)
dt = dataset
dt$START <- as.Date(dt$START)
dt$END <- as.Date(dt$END)
dt$STEP = factor(dt$STEP,levels=dt$STEP[rev(order(dt$STEP))])
color_ss = colorspace::qualitative_hcl(n = length(unique(dt$TEAM)), l = 60, c = 70)
dd = setNames(color_ss,unique(dt$TEAM))
START_LABEL <- as.Date(dt$START, "%Y-%m-%d")
END_LABEL <- as.Date(dt$END, "%Y-%m-%d")

ggplot(dt, aes(y=STEP)) +
       geom_segment(aes(x = START, y = STEP, xend = END, yend = STEP,color=TEAM))+
       geom_point(aes(x=START,color=TEAM))+
       geom_point(aes(x=END,color=TEAM))+
       geom_label(aes(x=START,label = format(START_LABEL, "%m-%d"),color=TEAM),fontface = "bold",nudge_x = -1.5,check_overlap = TRUE)+
       geom_label(aes(x=END,label = format(END_LABEL, "%m-%d"),color=TEAM),fontface = "bold",nudge_x = 1.5,check_overlap = TRUE)+
       xlim(min(dt$START)-2,max(dt$END)+2)+
       xlab(NULL)+
       ylab(NULL)+
       theme(
          panel.grid.major  = element_line(color = "#DCDCDC"),
          panel.background = element_rect(fill = "#FFFAF0"),
          panel.border = element_rect(color = "#FFFAF0", fill = NA),
          axis.line = element_line(color = "#FFFAF0"),
          axis.ticks = element_line(color = "lightblue"),
          axis.text.y = element_text(color =dd[rev(dt$TEAM)],size=12),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          plot.margin=unit(c(0,0,0,0), "cm")
       )