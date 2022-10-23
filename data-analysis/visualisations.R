###################################################################################################
# Online Experiments Seminar: Social Movement - Data Analysis - Data Visualisations
###################################################################################################

## imports
library(tidyverse)
library(gtsummary)

load("online_exp_df.RData")


# visualisations

######################### time spent on whole survey

v1 <- ggplot(df, aes(y = as.numeric(starttofinish))) +
                geom_boxplot(fill = "lightblue") +
                #labs(title = "Respondents' survey reponse time",
                 #    subtitle = "This excludes all responses taking longer than 120min.") +
                ylab("Response Time (minutes)") +
                theme_light() +
                theme(axis.title.x=element_blank(),
                      axis.text.x=element_blank(),
                      axis.ticks.x=element_blank()) 
v1

# exclude all obs with respondents taking more than 120min
df1 <- df %>% filter(as.numeric(starttofinish) <=120)

v2 <- ggplot(df1, aes(x = as.numeric(starttofinish))) +
  geom_histogram(binwidth = 0.5, fill = "lightblue") +
  geom_vline(aes(xintercept=median(starttofinish, na.rm=TRUE),linetype="Median: 9.4min"),
             size=0.5, color="deepskyblue4",
             show.legend = TRUE) +
  geom_vline(aes(xintercept=mean(starttofinish, na.rm=TRUE), linetype="Mean: 12.9min"),
             size=0.5, color="deepskyblue4",
             show.legend = TRUE) +
  #labs(title = "Survey Response Time") + #,
       #subtitle = "This excludes all responses taking longer than 120min.") +
  ylab("Freq.") + xlab("Response Time (minutes)") +
  theme_bw() +
  theme(legend.title=element_blank())
v2

summary(as.numeric(df1$starttofinish))

############################# time spent on treatment page 
df <- df %>% mutate(treatment_exposure = 
                      as.numeric(sm_time_participationpage - sm_time_treatmentpage))

v3 <- ggplot(df, aes(y = treatment_exposure)) +
  geom_boxplot(fill = "lightblue") +
  #labs(title = "Time spent on treatment page") +
  ylab("Exposure Time (seconds)") +
  theme_light() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) 
v3

# exclude all obs with respondents taking more than 5min/300s
df1 <- df %>% filter(treatment_exposure <=300)
df2 <- df %>% filter(!is.na(sm_participation))
df3 <- df %>% filter(treatment_exposure >10)

v4 <- ggplot(df1, aes(x = treatment_exposure)) +
  geom_histogram(binwidth = 1, fill = "lightblue") +
  geom_vline(aes(xintercept=median(treatment_exposure, na.rm=TRUE), linetype="Median: 25.0sec"),
             size=0.5, color="deepskyblue4",
             show.legend = TRUE) +
  geom_vline(aes(xintercept=mean(treatment_exposure, na.rm=TRUE), linetype="Mean: 32.9sec"),
             size=0.5, color="deepskyblue4",
             show.legend = TRUE) +
  #labs(title = "Exposure Time to Treatment Page") +#,
       #subtitle = "This excludes all responses taking longer than 5min.") +
  ylab("Freq.") + xlab("Exposure Time (seconds)") +
  theme_bw() +
  theme(legend.title=element_blank())
v4

summary(df1$treatment_exposure)


#################### participation

v5 <- df %>% filter(!is.na(sm_participation)) %>% 
  ggplot(aes(x=sm_participation, fill= sm_group_assignment)) +
  geom_bar(position="dodge") +
  #labs(title="Participation in Demonstration",
   #    subtitle="Mit welcher Wahrscheinlichkeit würden Sie an dieser Demonstration teilnehmen?", fill="Treatment Group")+
  ylab("") + xlab("Participation Likelihood") +
  scale_x_discrete(labels= c("Very low", "2", "3", "4", "Very High"))+
  scale_fill_brewer(palette="Set2", labels=c('1 low', '2 intermediate', '3 high'))+
  theme_light()
v5

v5_1 <- df %>% filter(!is.na(sm_participation)) %>% 
  ggplot(aes(x=sm_group_assignment, fill= sm_participation)) +
  geom_bar(position="dodge") +
  labs(
  #title="Participation in Demonstration",
   #    subtitle="Mit welcher Wahrscheinlichkeit würden Sie an dieser Demonstration teilnehmen?",
       fill="Participation Likelihood")+
  ylab("") + xlab("Treatment Group") +
  scale_x_discrete(labels= c('1 low', '2 intermediate', '3 high'))+
  scale_fill_brewer(palette="Blues", labels=c("Very low", "2", "3", "4", "Very High"))+
  theme_light()
v5_1


##################### participation factors
participation <- df %>% pivot_longer(cols = 42:50,
                                              names_to = "participation_factor",
                                              values_to = "participation_score",
                                              values_drop_na = TRUE)

v6 <- participation %>% filter(!is.na(sm_participation)) %>% 
  ggplot(aes(x=participation_score)) +
  geom_bar(fill="lightblue") +
  facet_wrap(vars(participation_factor), ncol=3,
             labeller = labeller(participation_factor = 
                                   c("sm_booked" = "Personal Plans",
                                     "sm_crowd" = "Crowd Concerns",
                                     "sm_familiar_people" = "Familiar People",
                                     "sm_number" = "Number Participants",
                                     "sm_polarization" = "Polarization",
                                     "sm_reach" = "Reach of Event",
                                     "sm_riots" = "Riots",
                                     "sm_topic_relevance" = "Topic Relevance",
                                     "sm_transportation" = "Transportation"))) +
  #labs(title="Factors influencing participation in demonstration",
   #    subtitle="Was beeinflusst die Wahrscheinlichkeit Ihrer Teilnahme an der gezeigten Demonstration?")+
  ylab("") + xlab("Influence Factor") +
  scale_x_discrete(labels= c("Not at all", "2", "3", "4", "A lot"))+
  scale_fill_brewer(palette="Set2")+
  theme_light()
v6


######################## political page
political <- df %>% pivot_longer(cols = 53:58,
                                     names_to = "political_factor",
                                     values_to = "political_score",
                                     values_drop_na = TRUE)

v7 <- political %>% filter(!is.na(sm_participation)) %>% 
  ggplot(aes(x=political_score)) +
  geom_bar(fill="lightblue") +
  facet_wrap(vars(political_factor), ncol=3,
             labeller = labeller(political_factor = 
                                   c("sm_missing_knowledge" = "Politics too complex",
                                     "sm_own_knowledge" = "Missing personal knowledge",
                                     "sm_general_knowledge" = "Missing general knowledge",
                                     "sm_future" = "Optimistic about future",
                                     "sm_unsure" = "Uncertainty since pandemic",
                                     "sm_olddays" = "Things used to be clearer"))) +
  #labs(title="Attitude towards Politics and the Future",
   #    subtitle="Inwieweit stimmen Sie den folgenden Aussagen zu oder nicht zu?")+
  ylab("") + xlab("Agreement") +
  scale_x_discrete(labels= c("Not at all", "2", "3", "4",  "A lot"))+
  scale_fill_brewer(palette="Set2")+
  theme_light()
v7


######################## demonstration page
demo <- df %>% pivot_longer(cols = 60:65,
                                 names_to = "demo_factor",
                                 values_to = "demo_score",
                                 values_drop_na = TRUE)

v8 <- demo %>% filter(!is.na(sm_participation)) %>% 
  ggplot(aes(x=demo_score)) +
  geom_bar(fill="lightblue") +
  facet_wrap(vars(demo_factor), ncol=3,
             labeller = labeller(demo_factor = 
                       c("sm_demonstration_change" = "...cannot bring change",
                         "sm_demonstration_democracy" = "...are important \nfor democracy",
                         "sm_demonstration_views" = "...are a tool \nto express views",
                         "sm_influence" = "Have no influence on politics",
                         "sm_interests" = "Politicians represent interests",
                         "sm_politicians" = "Politicians don't care about us"))) +
 # labs(title="Attitude towards Politics and Demonstrations",
  #     subtitle="Inwieweit stimmen Sie den folgenden Aussagen zu oder nicht zu?")+
  ylab("") + xlab("Agreement") +
  scale_x_discrete(labels= c("Not at all", "2", "3", "4",  "A lot"))+
  scale_fill_brewer(palette="Set2")+
  theme_light()
v8


####### save plots
ggsave("survey_time_box.png", plot=v1)
ggsave("survey_time_hist.png", plot=v2)
ggsave("treatment_time_box.png", plot=v3)
ggsave("treatment_time_hist.png", plot=v4)
ggsave("participation.png", plot=v5)
ggsave("participation_2.png", plot=v5_1)
ggsave("participation_factors.png", plot=v6)
ggsave("politics.png", plot=v7)
ggsave("demonstrations.png", plot=v8)




#### tables

tab1 <- df %>% select(sm_participation,sm_group_assignment) %>%
  tbl_cross(row = sm_participation,
            col = sm_group_assignment,
            percent = "cell",
            missing = "no",
            label = list(sm_participation ~ "Likelihood of Participation",
                         sm_group_assignment ~ "Treatment Group"))

tab1

library(gt)
as_gt(tab1) %>% gt::as_latex()

library(kableExtra)
as_kable_extra(tab1, format = "latex")
