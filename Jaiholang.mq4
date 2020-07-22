//+------------------------------------------------------------------+
//|                                                    Jaiholang.mq4 |
//|                                                        Jaiholang |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Jaiholang"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//#include <Telegram.mqh>
#import "Telegram4Mql.dll"
string TelegramSendTextAsync(string ApiKey, string ChatId, string ChatText);
#import

string apikey = "1053331191:AAFLEljRUmDlSDRVKkEQnk5BMmHf_-7ngxs";

string chatid_group = "-445043622"; // Group Jaiholang

extern int Pips = 50;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   string serverDateStr=TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS);
   
   string localDateStr=TimeToStr(LocalTime(),TIME_DATE|TIME_SECONDS);
   TelegramSendTextAsync(apikey, chatid_group, "Jaibot started..\n\nLocal Time: " + localDateStr + "\nServer Time: " + serverDateStr);

   WatchThesePairs();
   
//--- create timer
   EventSetTimer(300);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   //WatchForSpikes();

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
   WatchThesePairs();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

void WatchThesePairs()
  {

   WatchPair("AUDCAD");
   WatchPair("AUDCHF");
   WatchPair("AUDNZD");
   WatchPair("AUDJPY");
   WatchPair("AUDUSD");
   WatchPair("CADCHF");
   WatchPair("CADJPY");
   WatchPair("CHFJPY");
   WatchPair("EURAUD");
   WatchPair("EURCAD");
   WatchPair("EURCHF");
   WatchPair("EURGBP");
   WatchPair("EURJPY");
   WatchPair("EURNZD");
   WatchPair("EURUSD");
   WatchPair("GBPAUD");
   WatchPair("GBPCAD");

   WatchPair("GBPCHF");
   WatchPair("GBPJPY");
   WatchPair("GBPNZD");
   WatchPair("GBPUSD");
   WatchPair("NZDCAD");
   WatchPair("NZDCHF");
   WatchPair("NZDJPY");
   WatchPair("NZDUSD");
   WatchPair("USDCAD");
   WatchPair("USDJPY");
   //WatchPair("XAUUSD");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void WatchPair(string pairName)
  {

   double MacdCurrentM15, StochCurrentM15;//,MacdPrevious;
   double MacdCurrentM30, StochCurrentM30;//,MacdPrevious;

   MacdCurrentM15 = iMACD(pairName, PERIOD_M15, 12, 26, 1, PRICE_CLOSE, MODE_SIGNAL, 0);
   StochCurrentM15 = iStochastic(pairName, PERIOD_M15, 3, 1, 3, MODE_EMA, 1, MODE_MAIN, 0);

   MacdCurrentM30 = iMACD(pairName, PERIOD_M30, 12, 26, 1, PRICE_CLOSE, MODE_SIGNAL, 0);
   StochCurrentM30 = iStochastic(pairName, PERIOD_M30, 3, 1, 3, MODE_EMA, 1, MODE_MAIN, 0);

   if((MacdCurrentM15 > 0 && StochCurrentM15 < 20) && (MacdCurrentM30 > 0 && StochCurrentM30 < 20))
     {
      string message;
      message = StringConcatenate("BUY - ", pairName, "\n\n", "[M15]\nMACD : ", DoubleToStr(MacdCurrentM15, 6), "\nStoch : ", DoubleToStr(StochCurrentM15, 6), "\n\n", "[M30]\nMACD : ", DoubleToStr(MacdCurrentM30, 6), "\nStoch : ", DoubleToStr(StochCurrentM30, 6));
      TelegramSendTextAsync(apikey, chatid_group, message);
     }

   if((MacdCurrentM15 < 0 && StochCurrentM15 > 80) && (MacdCurrentM30 < 0 && StochCurrentM30 > 80))
     {
      string message;
      message = StringConcatenate("SELL - ", pairName, "\n\n", "[M15]\nMACD : ", DoubleToStr(MacdCurrentM15, 6), "\nStoch : ", DoubleToStr(StochCurrentM15, 6), "\n\n", "[M30]\nMACD : ", DoubleToStr(MacdCurrentM30, 6), "\nStoch : ", DoubleToStr(StochCurrentM30, 6));
      TelegramSendTextAsync(apikey, chatid_group, message);
     }

  }

//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  }