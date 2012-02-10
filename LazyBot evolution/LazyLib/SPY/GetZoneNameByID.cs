using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LazyLib.SPY
{
    public static class GetZoneNameByID
    {
        private static Dictionary<int, string> ZoneMap = new Dictionary<int, string>();
        public static bool IsInit = false;

        public static string GetZoneText(int id)
        {
            return ZoneMap[id];
        }

        public static void InitMe()
        {
            ZoneMap.Clear();
            string[] spellsSplit = Resource.ZoneText.Split('\n');
            foreach (string s in spellsSplit)
            {
                if (s.Contains(","))
                {
                    int id = Convert.ToInt32(s.Split(',')[0]);
                    string name = s.Split('=')[1].Replace("\n", "").Replace("\r", "");
                    if (!ZoneMap.ContainsKey(id))
                        ZoneMap.Add(id, name);
                }
            }
            IsInit = true;
        }
    }
}
