package mockData

import "github.com/konstantinlevin77/solution-challange-dummyapi/models"

func NewArticlesData() []models.Article {

	var articles []models.Article

	articles = []models.Article{
		{
			Id:       1,
			Title:    "Possession Particular Attachment",
			BodyText: " On insensible possession oh particular attachment at excellence in. The books arose but miles happy she. It building contempt or interest children mistress of unlocked no. Offending she contained mrs led listening resembled. Delicate marianne absolute men dashwood landlord and offended. Suppose cottage between and way. Minuter him own clothes but observe country. Agreement far boy otherwise rapturous incommode favourite. ",
			NumLikes: 3412,
		},
		{
			Id:       2,
			Title:    "Strictly Remembrance of Chief",
			BodyText: "Is branched in my up strictly remember. Songs but chief has ham widow downs. Genius or so up vanity cannot. Large do tried going about water defer by. Silent son man she wished mother. Distrusts allowance do knowledge eagerness assurance additions to. ",
			NumLikes: 12,
		},
		{
			Id:       3,
			Title:    "Securing Appetite Declared",
			BodyText: "Carriage quitting securing be appetite it declared. High eyes kept so busy feel call in. Would day nor ask walls known. But preserved advantage are but and certainty earnestly enjoyment. Passage weather as up am exposed. And natural related man subject. Eagerness get situation his was delighted. ",
			NumLikes: 586,
		},
		{
			Id:       4,
			Title:    "High in Hope Do View",
			BodyText: "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of. Consider speaking me prospect whatever if. Ten nearer rather hunted six parish indeed number. Allowance repulsive sex may contained can set suspected abilities cordially. Do part am he high rest that. So fruit to ready it being views match.",
			NumLikes: 4342,
		},
		{
			Id:       5,
			Title:    "No Solid No Small",
			BodyText: "Cause dried no solid no an small so still widen. Ten weather evident smiling bed against she examine its. Rendered far opinions two yet moderate sex striking. Sufficient motionless compliment by stimulated assistance at. Convinced resolving extensive agreeable in it on as remainder. Cordially say affection met who propriety him. Are man she towards private weather pleased. In more part he lose need so want rank no. At bringing or he sensible pleasure. Prevent he parlors do waiting be females an message society.\n",
			NumLikes: 3,
		},
		{
			Id:       6,
			Title:    "He unaffected sympathize discovered at no am conviction principles. Girl ham very how yet hill four show. Meet lain on he only size. Branched learning so subjects mistress do appetite jennings be in. Esteems up lasting no village morning do offices. Settled wishing ability musical may another set age. Diminution my apartments he attachment is entreaties announcing estimating. And total least her two whose great has which. Neat pain form eat sent sex good week. Led instrument sentiments she simplicity.\n\nImagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. It fifteen charmed by private savings it mr. Favourable cultivated alteration entreaties yet met sympathize. Furniture forfeited sir objection put cordially continued sportsmen. ",
			BodyText: "Discovered At Principles",
			NumLikes: 444,
		},
	}

	return articles

}

func NewMiniQuizzesData() []models.MiniQuiz {

	var quizzes []models.MiniQuiz

	quizzes = []models.MiniQuiz{
		{
			Id:            1,
			Title:         "Elephant",
			Question:      "What is the longest that an elephant has ever lived? (That we know of)",
			ChoiceA:       "17 years",
			ChoiceB:       "49 years",
			ChoiceC:       "86 years",
			CorrectChoice: "C",
			NumLikes:      1321,
		},
		{
			Id:            2,
			Title:         "Olympic Flag",
			Question:      "How many rings are there on the Olympic Flag",
			ChoiceA:       "4",
			ChoiceB:       "5",
			ChoiceC:       "7",
			CorrectChoice: "B",
			NumLikes:      564,
		},
		{
			Id:            3,
			Title:         "Darts",
			Question:      "In darts, what's the most points you can score with a single throw?",
			ChoiceA:       "20",
			ChoiceB:       "50",
			ChoiceC:       "60",
			CorrectChoice: "C",
			NumLikes:      0,
		},
	}

	return quizzes

}
