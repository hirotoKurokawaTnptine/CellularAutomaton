Add-Type -TypeDefinition @'
using System;
using System.Numerics;
using System.Linq;

public class CAConsoleVisualizer {
    
    private static object lockObj = new object();
    private static readonly char TrueChar   = '*';
    private static readonly char FalseChar  = ' ';
    private static readonly char BorderChar    = '|';
    private static readonly char RowBorderChar = '-';

    public static void ShowCA(BigInteger[] board, uint startWidth, uint lengthWidth, uint startHeight, uint lengthHeight) {
        int consoleHeight = Console.WindowHeight - 2;
        int consoleWidth  = Console.WindowWidth  - 2;

        if (startWidth >= lengthWidth)   { throw new ArgumentException("StartWidth must be less than LengthWidth");   }
        if (startHeight >= lengthHeight) { throw new ArgumentException("StartHeight must be less than LengthHeight"); }

        if ((startWidth + lengthWidth - 3) <= consoleWidth) {
            consoleWidth = (int)(startWidth + lengthWidth - 3);
        }

        if ((startHeight + lengthHeight - 3) <= consoleHeight) {
            consoleHeight = (int)(startHeight + lengthHeight - 3);
        }

        try {
            String[] stringRows = new string[consoleHeight];
            System.Threading.Tasks.Parallel.For(startHeight, startHeight + consoleHeight, y => {
                System.Text.StringBuilder rowSb = new System.Text.StringBuilder();
                rowSb.Append(BorderChar);
                for (uint x = startWidth; x < startWidth + consoleWidth; x++) {
                    bool cellState = ((board[y] >> (int)x) & 1) == 1;
                    rowSb.Append(cellState ? TrueChar : FalseChar);
                }
                rowSb.Append(BorderChar);
                lock (lockObj) {
                    stringRows[y] = rowSb.ToString();
                }
            }); 

            string rowBorder = new string(RowBorderChar, consoleWidth + 2);
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.AppendLine(rowBorder);
            foreach (String row in stringRows) {
                sb.AppendLine(row);
            }
            sb.AppendLine(rowBorder);
            Console.CursorVisible = false;
            Console.ForegroundColor = ConsoleColor.Green;
            Console.SetCursorPosition(0, 0);
            Console.Write(sb.ToString());
            Console.ResetColor();
        } catch (AggregateException ae) {
            throw ae.Flatten().InnerExceptions[0];
        }
    }
}

'@ -Language CSharp -ReferencedAssemblies "System.Numerics"