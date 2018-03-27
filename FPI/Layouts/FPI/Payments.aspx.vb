Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Web.UI
Imports System.Data.SqlClient
Imports System.Text
Imports System.IO

Namespace Layouts.FPI

    Partial Public Class Payments
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        End Sub

        Protected Sub ExportToExcel(ByVal sender As Object, ByVal e As System.EventArgs) Handles ExportBtn1.Click

            'Create a dummy GridView
            Dim GridViewTemp As New GridView()
            GridViewTemp.AllowPaging = False
            GridViewTemp.DataSource = CCHSql
            GridViewTemp.DataBind()

            Response.Clear()
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment;filename=WIPData.xls")
            Response.Charset = ""
            Response.ContentType = "application/vnd.ms-excel"
            Dim sw As New StringWriter()
            Dim hw As New HtmlTextWriter(sw)

            For i As Integer = 0 To GridViewTemp.Rows.Count - 1
                'Apply text style to each Row
                GridViewTemp.Rows(i).Attributes.Add("class", "textmode")
            Next
            GridViewTemp.RenderControl(hw)

            'style to format numbers to string
            Dim style As String = "<style> .textmode{mso-number-format:\@;}</style>"
            Response.Write(style)
            Response.Output.Write(sw.ToString())
            Response.Flush()
            Response.End()
        End Sub


    End Class

End Namespace
