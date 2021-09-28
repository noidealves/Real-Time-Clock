//+------------------------------------------------------------------+
//|                                              Real Time Clock.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

enum POSITION 
{
   LEFT,
   RIGHT
};

input POSITION clockPosition = RIGHT; //Clock Position

long height = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
long width = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);

int buttonSizeX = (int)(width / 100) * 8;
int buttonSizeY = (int)(height / 100) * 4;
int buttonFontSize = ((buttonSizeX + buttonSizeY) / 12);

MqlDateTime dt;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int OnInit()
{
   CreateDatetime();
   EventSetTimer(1);
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+

void OnDeinit(const int reason)
{
   ObjectDelete(0, "DateTime");
   EventKillTimer();
}

//+------------------------------------------------------------------+
//| Expert timer function                                             |
//+------------------------------------------------------------------+

void OnTimer()
{
   TimeLocal(dt);
   SetDatetime(dt.hour, dt.min, dt.sec);
   ChartRedraw();
}

//+------------------------------------------------------------------+

void SetDatetime(int iHour, int iMinute, int iSecond)
{
   string sHour = PadLeft(string(iHour), 2);
   string sMinute = PadLeft(string(iMinute), 2);
   string sSecond = PadLeft(string(iSecond), 2);

   ObjectSetString(0, "DateTime", OBJPROP_TEXT, sHour + ":" + sMinute + ":" + sSecond);
}

void CreateDatetime()
{
   ObjectDelete(0, "DateTime");
   ObjectCreate(0, "DateTime", OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, "DateTime", OBJPROP_COLOR, clrBlack);
   ObjectSetInteger(0, "DateTime", OBJPROP_XSIZE, buttonSizeX);
   ObjectSetInteger(0, "DateTime", OBJPROP_YSIZE, buttonSizeY);
   ObjectSetInteger(0, "DateTime", OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0, "DateTime", OBJPROP_XDISTANCE, clockPosition == RIGHT ? buttonSizeX + ((width / 100) * 2) : width - ((width / 100) * 2));
   ObjectSetInteger(0, "DateTime", OBJPROP_YDISTANCE, (height / 100) * 5);
   ObjectSetString(0, "DateTime", OBJPROP_FONT, "Arial");
   ObjectSetInteger(0, "DateTime", OBJPROP_FONTSIZE, buttonFontSize);
   ObjectSetInteger(0, "DateTime", OBJPROP_BGCOLOR, clrWhite);
   ObjectSetInteger(0, "DateTime", OBJPROP_ALIGN, ALIGN_CENTER);
   ObjectSetInteger(0, "DateTime", OBJPROP_SELECTABLE, true);
}

string PadLeft(string S, int toLength)
{
   string str = S, pad = "0";

   while (StringLen(str) < toLength)
   {
      str = pad + str;
   }

   return str;
}
