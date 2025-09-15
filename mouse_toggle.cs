using System;
using System.IO;
using System.Diagnostics;
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

        static bool SaveButtonsState(bool lefthanded)
        {
            bool result = false;

            try
            {
                RegistryKey mouse_key = Registry.CurrentUser.OpenSubKey(@"Control Panel\Mouse", true);
                mouse_key.SetValue(@"SwapMouseButtons", lefthanded ? "1" : "0");
                result = true;
                mouse_key.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine("{0}: unable to SaveButtonsState", e.Message);
            }

            return result;
        }
            
        static int Main(string[] args)
        {
            string[] allowed = { "n", "l", "xl" };
            if (args.Length != 1 || Array.IndexOf(allowed, args[0]) < 0)
            {
                string my_executable = Path.GetFileName(Process.GetCurrentProcess().MainModule.FileName);
                Console.WriteLine("Usage: {0} [n|l|xl]\n\tn -- normal cursor size\n\tl -- large cursor size\n\txl -- extra large cursor size", my_executable);
                return 1;
            }
            string size = args[0];
            string predefined_lefthanded_scheme_name = string.Format("mouse_toggle_scheme_left_{0}", size);
            string predefined_righthanded_scheme_name = string.Format("mouse_toggle_scheme_right_{0}", size);
            bool leftHandedNow = SwapMouseButton(true);
            if (leftHandedNow)
            {
                SwapMouseButton(false);
                SaveButtonsState(false);
                SetCursorScheme(predefined_righthanded_scheme_name);
            }
            else
            {
                SaveButtonsState(true);
                SetCursorScheme(predefined_lefthanded_scheme_name);
            }
            ApplyCursorScheme();
        }
    }
}
