using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;
using Microsoft.Win32;

namespace mouse_switcher
{
    class mouse_switcher
    {
        [DllImport("user32.dll", SetLastError = true)]
        static extern bool SystemParametersInfo(uint uiAction, uint uiParam, IntPtr pvParam, uint fWinIni);

        [DllImport("user32.dll")]
        static extern bool SwapMouseButton(bool fSwap);

        static bool SetCursorScheme(string schemeName)
        {
            bool result = false;
            string[] cursor_names = 
            {
                "Arrow", "Help", "AppStarting",
                "Wait", "Crosshair", "IBeam",
                "NWPen", "No", "SizeNS",
                "SizeWE", "SizeNWSE", "SizeNESW",
                "SizeAll", "UpArrow", "Hand" 
            };

            string schemes_key = @"Control Panel\Cursors\Schemes";
            string current_scheme_key = @"Control Panel\Cursors";
            
            string cursor_set = "";
            RegistryKey scheme = Registry.CurrentUser.OpenSubKey(schemes_key, false);
            if ( scheme != null )
            {
                try
                {
                    cursor_set = scheme.GetValue(schemeName).ToString();
                }
                catch (Exception)
                {
                    Console.WriteLine("{0}: unable to read scheme", schemeName);
                }

                scheme.Close();
            }

            string[] filenames = cursor_set.Split(',');
            if (filenames.Length != cursor_names.Length)
            {
                Console.WriteLine("{0}: item count mismatch", schemeName);
            }
            else
            {
                Console.WriteLine("{0}: is good", schemeName);
                RegistryKey current_scheme = Registry.CurrentUser.OpenSubKey(current_scheme_key, true);
                current_scheme.SetValue("", schemeName);
                current_scheme.SetValue("Scheme Source", 1);
                for (int i = 0; i < cursor_names.Length; i++)
                {
                    Console.WriteLine("{0} -> {1}", cursor_names[i], filenames[i]);
                    current_scheme.SetValue(cursor_names[i], filenames[i].Trim());
                }
                current_scheme.Close();
                result = true;
            }
            return result;
        }

        static bool ApplyCursorScheme()
        {
            const uint SPI_SETCURSORS = 0x0057;
            const uint SPIF_UPDATEINIFILE = 0x01;
            const uint SPIF_SENDCHANGE = 0x02;
            return SystemParametersInfo(SPI_SETCURSORS, 0, IntPtr.Zero, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
        }
            
        static void Main(string[] args)
        {
            string predefined_lefthanded_scheme_name = "mouse_toggle_scheme_left";
            string predefined_righthanded_scheme_name = "mouse_toggle_scheme_right";
            bool leftHandedNow = SwapMouseButton(true);
            if (leftHandedNow)
            {
                SwapMouseButton(false);
                SetCursorScheme(predefined_righthanded_scheme_name);
            }
            else
            {
                SetCursorScheme(predefined_lefthanded_scheme_name);
            }
            ApplyCursorScheme();
        }
    }
}
