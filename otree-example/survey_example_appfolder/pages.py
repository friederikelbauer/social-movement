from otree.api import Currency as c, currency_range, safe_json
from ._builtin import Page, WaitPage
from .models import Constants, Player



class Welcome(Page):
    form_model = Player
    form_fields = []

class TreatmentPage(Page):
    form_model = Player
    form_fields = ['sm_participation']

    def vars_for_template(self):
        return {'sm_group_assignment': safe_json(self.player.sm_group_assignment)}

class ParticipationPage(Page):
    form_model = Player
    form_fields=['sm_topic_relevance', 'sm_familiar_people', 'sm_booked', 'sm_transportation', 'sm_reach', 'sm_crowd', 
    'sm_polarization', 'sm_riots', 'sm_participation_else']

class PoliticalPage(Page):
    form_model = Player
    form_fields=['sm_political_participation', 'sm_political_influence', 'sm_political_chance',
    'sm_future', 'sm_unsure', 'sm_olddays']

class EndPage(Page):

    form_model = Player

page_sequence = [Welcome,
                TreatmentPage,
                ParticipationPage,
                PoliticalPage,
                EndPage]