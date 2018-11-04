class Plan
{
	var all_purchases : [String : [Purchase]] = [
        ‘transport’: [String](), 
        ‘education’: [String](),
        ‘health’:  [String](),
        ‘shopping’: [String](), 
        ‘entertainment’: [String](),
        ‘food’: [String]()
    ]

    var category_budget : [String : Int] = [
        ‘transport’: 0,
        ‘education’: 0,
        ‘health’:  0,
        ‘shopping’: 0, 
        ‘entertainment’: 0,
        ‘food’: 0
    ]

    init(budget: Int)
    {
	    self.budget = budget
	    self.balance = budget
    }

    func add_purchase(purchase: [Purchase])
    {
	    self.all_purchases[purchase.category].append(purchase)
	    self.balance = self.balance - purchase.price
    }

    func add_category(new_category: String)
    {
	    all_purchases[new_category] = [String]() 
	    category_budget[new_category] = 0
    }
}




class Category_Plan: Plan
{
	init(budget: Int)
    {
	    self.budget = budget
	    self.balance = budget
    }
}


class Next_Plan: Plan
{

    init(current_plan: Plan, budget: Int = -1)
    {
	    if budget > 0
        {
		    self.budget = current_plan.budget
	    }
	    else
        {
            self.budget = budget
    	}
    }
}

func make_estimation()
{
    var estimation = [String : Double]()
	    for  category in self.all_purchases.keys
        {
		    for purchase in self.all_purchases[category]
            {
			    var category_score = estimation.get(category, 0)
			    category_score = category_score + purchase.impulse_proportion
		    }
		    estimation[category] = category_score
		}
	
        var score_sum = estimation.values.reduce(0, +)
	    for category in estimation.keys
        {
		    category_budget[category] = budget * estimation[category] / score_sum
        }
}



class Purchase
{	
	var rated = false
	var imp_type: String? = nil

	init (date: NSDate? , category: String, price: Double, current_plan: Plan)
    {
		self.date = date
		self.category = category
		self.price = price
		current_plan.add_purchase(self)
	}

	func apply_emo(emo_index: Int)
    {
		self.emo = emo_index
	}

	func apply_feedback(fb_index: Int = 0)
    {
		self.feedback = fb_index
		self.rated = True
    }

	func measure_type() -> String
    {
        self.impulsion = (self.emo - self.feedback + 9) / 18
        self.impulse_proportion = self.impulsion * self.price

	    if self.impulsion > 0.5
        {
			self.imp_type = "impulsion"
		}
	    else if self.impulsion == 0.5
        {
            self.imp_type = "neutral"
        }
        else
        {
			self.imp_type = "positive"
		}

		return self.imp_type
	}
}