from otree.api import Currency as c, currency_range, safe_json
from ._builtin import Page, WaitPage
from .models import Constants, Player



class Welcome(Page):
    form_model = Player
    form_fields = []

class TreatmentPage(Page):
    form_model = Player
    form_fields = []

class ParticipationPage(Page):
    form_model = Player
    form_fields=['participation', 'topic_relevance', 'familiar_people', 'booked', 'transportation', 'reach', 'crowd', 
    'polarization', 'riots', 'participation_else']

class PoliticalPage(Page):
    form_model = Player

class EndPage(Page):

    form_model = Player

page_sequence = [Welcome,
                TreatmentPage,
                ParticipationPage,
                PoliticalPage,
                EndPage]