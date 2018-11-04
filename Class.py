class Plan(object):

	all_purchases = {
		'transport' : [],
		'education' : [],
		'health' : [],
		'shopping' : [],
		'entertainment' : [],
		'food' : []
	}

	category_budget = {
		'transport' : 0,
		'education' : 0,
		'health' : 0,
		'shopping' : 0,
		'entertainment' : 0,
		'food' : 0
	}

	def __init__(self, budget):
		self.budget = budget
		self.balance = budget

	def add_purchase(self, purchase):
		self.all_purchases[purchase.category].append(purchase)
		self.balance -= purchase.price

	def add_category(self, new_category):
		Plan.all_purchases[new_category] = []
		Plan.category_budget[new_category] = 0




class Category_Plan(Plan):

	def __init__(self, budget):
		self.budget = budget
		self.balance = budget

	


class Next_Plan(Plan):
	
	def __init__(self, current_plan, budget=-1):
		if budget < 0:
			self.budget = current_plan.budget
		else:
			self.budget = budget
		
	def make_estimation(self):
		estimation = {}
		for category in self.all_purchases.keys():
			for purchase in self.all_purchases[category]: # Purchase instances
				category_score = estimation.get(category, 0)
				category_score += purchase.impulse_proportion
			estimation[category] = category_score

		score_sum = sum(estimation.values())
		for category in estimation.keys():
		self.category_budget[category] = self.budget * estimation[category] / score_sum



class Purchase(object):

	rated = False
	imp_type = ''

	def __init__(self, date, category, price, current_plan):
		self.date = date
		self.category = category 		
		self.price = price
		current_plan.add_purchase(self)

	def apply_emo(self, emo_index): # emo_index in range [1, 10]
		self.emo = emo_index

	def apply_feedback(self, fb_index=0): # fb_index in range [1, 10]
		self.feedback = fb_index
		self.rated = True

	def measure_type(self):
		# self.emo - self.feedback in range [-9, 9]
		self.impulsion = (- self.emo + self.feedback + 9) / 18 # Ranges from 0 to 1, with Neutral value at 0.5
		self.impulse_proportion = self.impulsion * self.price

		if self.impulsion < 0.5:
			self.imp_type = "impulsion"
		elif self.impulsion == 0.5:
			self.imp_type = "neutral"
		else:
			self.imp_type = "positive"
		
		return self.imp_type





