# hw6

## GiveMeSomeCredit

Start here! Predict the probability that somebody will experience financial distress in the next two years.

[GiveMeSomeCredit](https://www.kaggle.com/c/GiveMeSomeCredit/overview)

## Steps

1. perform *n*-fold cross-validation on the training data under three-way split to select the best prediction model
2. report the average accuracy of cross-validation (training, validation, testing in *n*-fold cross-validation), i.e., hw4
3. then apply the selected model on the test data
4. output prediction result

```R
Rscript hw6_studentID.R --fold n --train Data/train.csv --test Data/test.csv --report performance.csv --predict predict.csv
```

5. Submit your prediction to Kaggle system under display name: [葉冠宏]_1082DS@NCCU
6. Make a snapshot of your score on Leaderboard and update in your README.md

![GiveMeSomeCreditLeaderBoard](score1.png)
![GiveMeSomeCreditLeaderBoard](score2.png)

我用的是 5 個 folds 得到的 Accuracy.
## Score

* 6 testing parameters from fold 5 to fold 10

```R
Rscript hw6_9999.R --fold 5 --train Data/train.csv --test Data/test.csv --report performance1.csv --predict predict.csv
...
Rscript hw6_9999.R --fold 10 --train Data/train.csv --test Data/test.csv --report performance6.csv --predict predict.csv
```
Each testing parameters get 15 points.
**Please do not set input/output in your local path or URL.** 
Otherwise, your code will fail due to fixed path problem.

Penalty: without training, calibration, testing answer (-5 points of each answer)

## Bonus
* Round number to two decimal places: 2 points
* Performance Bonus: average testing performance
  * 0.85 ~ : 4 points
  * 0.80 ~ 0.85 : 3 points
  * 0.75 ~ 0.80 : 2 points
  * 0.70 ~ 075 : 1 points
* Average testing performance is closed to the score of Kaggle (<= 0.05): 4 points
