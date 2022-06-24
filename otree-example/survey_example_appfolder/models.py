from otree.api import (
    models,
    widgets,
    BaseConstants,
    BaseSubsession,
    BaseGroup,
    BasePlayer,
    Currency as c,
    currency_range,
)
import random


author = '''Team Social Movement, 
Friederike Bauer, Leslie Fischer, Lina Jeannot, Freya Moßig, Pascal Mounchid, Anna Schleiter Nielsen'''
doc = '''Social Movements:
How does social pressure impact the probability of joining a demonstration?'''

class Constants(BaseConstants):
    name_in_url = 'survey-example'
    players_per_group = None
    num_rounds = 1

class Subsession(BaseSubsession):
    def creating_session(self):
        '''we are declaring the group assignment here'''
        for p in self.get_players():
            p.sm_group_assignment = random.Random().randint(1, 3)


class Group(BaseGroup):
    pass


class Player(BasePlayer):

# Social Movement (sm) variables
    #general varibles
    sm_group_assignment = models.IntegerField(initial=-999)
    #TreatmentPage
    sm_participation = models.IntegerField(initial=-999)
    #ParticipationPage
    sm_topic_relevance = models.IntegerField(initial = -999)
    sm_familiar_people = models.IntegerField(initial=-999)
    sm_booked = models.IntegerField(initial=-999)
    sm_transportation = models.IntegerField(initial = -999)
    sm_reach = models.IntegerField(initial=-999)
    sm_crowd = models.IntegerField(initial=-999)
    sm_polarization = models.IntegerField(initial=-999)
    sm_riots = models.IntegerField(initial=-999)
    sm_participation_else = models.StringField(blank=True) #voluntary
    #PoliticalPage
    sm_political_participation = models.IntegerField(initial=-999)
    sm_political_influence = models.IntegerField(initial=-999)
    sm_political_chance = models.IntegerField(initial=-999)
    sm_future = models.IntegerField(initial=-999)
    sm_unsure = models.IntegerField(initial=-999)
    sm_olddays = models.IntegerField(initial=-999)
                        