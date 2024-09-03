package database

import "api/models"

var questions = []models.Question{
    {
        ID:       1,
        Question: "What is a candlestick pattern in trading?",
        Options: []models.Option{
            {ID: 1, Text: "A decorative candle"},
            {ID: 2, Text: "A pattern used in technical analysis"},
            {ID: 3, Text: "A market trend"},
            {ID: 4, Text: "A stock exchange term"},
        },
        CorrectAnswer: 2,
        ImageUrl:      "https://example.com/candlestick.jpg", // Valid URL
    },
    {
        ID:       2,
        Question: "What does a 'bull market' signify?",
        Options: []models.Option{
            {ID: 1, Text: "Market is declining"},
            {ID: 2, Text: "Market is stagnant"},
            {ID: 3, Text: "Market is rising"},
            {ID: 4, Text: "Market is highly volatile"},
        },
        CorrectAnswer: 3,
        ImageUrl:      "https://example.com/bull_market.jpg", // Valid URL
    },
    {
        ID:       3,
        Question: "What does 'P/E Ratio' stand for?",
        Options: []models.Option{
            {ID: 1, Text: "Profit/Earnings Ratio"},
            {ID: 2, Text: "Price/Earnings Ratio"},
            {ID: 3, Text: "Purchase/Earnings Ratio"},
            {ID: 4, Text: "Percentage/Earnings Ratio"},
        },
        CorrectAnswer: 2,
        ImageUrl:      "https://example.com/pe_ratio.jpg", // Valid URL
    },
    {
        ID:       4,
        Question: "What is 'short selling'?",
        Options: []models.Option{
            {ID: 1, Text: "Selling a stock before buying it"},
            {ID: 2, Text: "Selling a stock after a price increase"},
            {ID: 3, Text: "Selling a stock for a profit"},
            {ID: 4, Text: "Selling a stock for a loss"},
        },
        CorrectAnswer: 1,
        ImageUrl:      "https://example.com/short_selling.jpg", // Valid URL
    },
    {
        ID:       5,
        Question: "What is 'leverage' in trading?",
        Options: []models.Option{
            {ID: 1, Text: "Borrowing capital to increase the potential return"},
            {ID: 2, Text: "Investing in multiple stocks"},
            {ID: 3, Text: "Reducing risk by diversification"},
            {ID: 4, Text: "Buying stocks at a lower price"},
        },
        CorrectAnswer: 1,
        ImageUrl:      "https://media.istockphoto.com/id/1064250164/photo/candlestick-chart-red-green-in-financial-market-for-trading-on-black-color-background.jpg?s=2048x2048&w=is&k=20&c=KSEOFBMqL2iJwcf1Pz1ZhaWKNU8C14lO0Y-RK2NfTd0=", // Valid URL
    },
    {
        ID:       6,
        Question: "Which indicator is used to measure market volatility?",
        Options: []models.Option{
            {ID: 1, Text: "MACD"},
            {ID: 2, Text: "RSI"},
            {ID: 3, Text: "VIX"},
            {ID: 4, Text: "Bollinger Bands"},
        },
        CorrectAnswer: 3,
        ImageUrl:      "https://media.istockphoto.com/id/1064250164/photo/candlestick-chart-red-green-in-financial-market-for-trading-on-black-color-background.jpg?s=2048x2048&w=is&k=20&c=KSEOFBMqL2iJwcf1Pz1ZhaWKNU8C14lO0Y-RK2NfTd0=", // Valid URL
    },
    {
        ID:       7,
        Question: "What is the 'Dow Jones Industrial Average'?",
        Options: []models.Option{
            {ID: 1, Text: "An individual stock"},
            {ID: 2, Text: "A measure of U.S. market performance"},
            {ID: 3, Text: "A type of investment strategy"},
            {ID: 4, Text: "A type of financial instrument"},
        },
        CorrectAnswer: 2,
        ImageUrl:      "https://media.istockphoto.com/id/1064250164/photo/candlestick-chart-red-green-in-financial-market-for-trading-on-black-color-background.jpg?s=2048x2048&w=is&k=20&c=KSEOFBMqL2iJwcf1Pz1ZhaWKNU8C14lO0Y-RK2NfTd0=", // Valid URL
    },
    {
        ID:       8,
        Question: "What does 'IPO' stand for?",
        Options: []models.Option{
            {ID: 1, Text: "Initial Purchase Order"},
            {ID: 2, Text: "Internal Public Offering"},
            {ID: 3, Text: "Initial Public Offering"},
            {ID: 4, Text: "International Purchase Offering"},
        },
        CorrectAnswer: 3,
        ImageUrl:      "https://media.istockphoto.com/id/1064250164/photo/candlestick-chart-red-green-in-financial-market-for-trading-on-black-color-background.jpg?s=2048x2048&w=is&k=20&c=KSEOFBMqL2iJwcf1Pz1ZhaWKNU8C14lO0Y-RK2NfTd0=", // Valid URL
    },
    {
        ID:       9,
        Question: "What is the purpose of a 'stop-loss order'?",
        Options: []models.Option{
            {ID: 1, Text: "To maximize profit"},
            {ID: 2, Text: "To limit potential loss"},
            {ID: 3, Text: "To buy stocks automatically"},
            {ID: 4, Text: "To track stock performance"},
        },
        CorrectAnswer: 2,
        ImageUrl:      "https://media.istockphoto.com/id/1064250164/photo/candlestick-chart-red-green-in-financial-market-for-trading-on-black-color-background.jpg?s=2048x2048&w=is&k=20&c=KSEOFBMqL2iJwcf1Pz1ZhaWKNU8C14lO0Y-RK2NfTd0=", // Valid URL
    },
    {
        ID:       10,
        Question: "What is 'dividend' in stocks?",
        Options: []models.Option{
            {ID: 1, Text: "A bonus for employees"},
            {ID: 2, Text: "Interest on a bond"},
            {ID: 3, Text: "A payment made to shareholders"},
            {ID: 4, Text: "A fee paid to brokers"},
        },
        CorrectAnswer: 3,
        ImageUrl:      "https://example.com/dividend.jpg", // Valid URL
    },
}

func GetQuestions() []models.Question {
    return questions
}

func CheckAnswers(userAnswers []models.UserAnswer) models.QuizResult {
    var result models.QuizResult

    for _, userAnswer := range userAnswers {
        for _, question := range questions {
            if question.ID == userAnswer.QuestionID {
                if question.CorrectAnswer == userAnswer.AnswerID {
                    result.CorrectAnswers++
                } else {
                    result.IncorrectAnswers++
                }
                break
            }
        }
    }

    return result
}
