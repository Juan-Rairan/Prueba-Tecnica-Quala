using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Descripción breve de Globals
/// </summary>
public static class Globals
{
    public static string Encriptar(string m_enc)
    {
        byte[] toEncodeAsBytes = System.Text.Encoding.UTF8.GetBytes(m_enc);
        string returnValue = System.Convert.ToBase64String(toEncodeAsBytes);
        return returnValue;
    }

    public static string DesEncriptar(string m_enc)
    {
        byte[] encodedDataAsBytes = System.Convert.FromBase64String(m_enc);
        string returnValue = System.Text.Encoding.UTF8.GetString(encodedDataAsBytes);
        return returnValue;
    }
    public static string set_a_json(DataSet ds)
    {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.Append("[");
        for (int i = 0; i < ds.Tables.Count; i++)
        {
            DataTable dataTable = ds.Tables[i];
            if (i > 0)
            {
                stringBuilder.Append(",");
            }

            stringBuilder.Append("[");
            for (int j = 0; j < dataTable.Rows.Count; j++)
            {
                if (j > 0)
                {
                    stringBuilder.Append(",");
                }
                stringBuilder.Append("{");
                for (int k = 0; k < dataTable.Columns.Count; k++)
                {
                    if (k > 0)
                    {
                        stringBuilder.Append(",");
                    }
                    stringBuilder.Append(string.Concat("\"", LimpiarCaracteres(dataTable.Columns[k].ColumnName), "\":\"", LimpiarCaracteres(dataTable.Rows[j][k].ToString()), "\""));
                }

                stringBuilder.Append("}");
            }
            stringBuilder.Append("]");
        }

        stringBuilder.Append("]");
        return stringBuilder.ToString();
    }
    private static string LimpiarCaracteres(string data)
    {
        const string reduceMultiSpace = @"[ ]{2,}";
        string rta = Regex.Replace(data.Replace("\t", " "), reduceMultiSpace, " ");

        rta = data.Replace("\"", "").Replace("\\", "").Replace("/", "").Replace("{", "").Replace("}", "").Replace("\t", "").Replace("\b", "").Replace("\f", "").Replace("\n", "").Replace("\r", "");
        return rta;
    }
}