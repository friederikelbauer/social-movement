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

author = '''Team Social Movement, 
Friederike Bauer, Leslie Fischer, Lina Jeannot, Freya Moßig, Pascal Mounchid, Anna Schleiter Nielsen'''
doc = '''Social Movements:
How does social pressure impact the probability of joining a demonstration?'''

class Constants(BaseConstants):
    name_in_url = 'survey-example'
    players_per_group = None
    num_rounds = 1

class Subsession(BaseSubsession):
    pass

class Group(BaseGroup):
    pass


class Player(BasePlayer):
    #ParticipationPage
    participation = models.IntegerField(initial=-999)
    topic_relevance = models.IntegerField(initial = -999)
    familiar_people = models.IntegerField(initial=-999)
    booked = models.IntegerField(initial=-999)
    transportation = models.IntegerField(initial = -999)
    reach = models.IntegerField(initial=-999)
    crowd = models.IntegerField(initial=-999)
    polarization = models.IntegerField(initial=-999)
    riots = models.IntegerField(initial=-999)
    participation_else = models.StringField(blank=True)

                        