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

    Partial Public Class Notify
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            UserLbl.Text = UserName.Substring(InStr(UserName, "\"))

            Dim PermittedDV As DataView = DirectCast(PermittedSQL.Select(DataSourceSelectArguments.Empty), DataView)
            If CType(PermittedDV.Table.Rows(0)("permitted"), Integer) = 0 Then
                UpdateBtn.Enabled = False
            Else
                UpdateBtn.Enabled = True

            End If

        End Sub

        Protected Sub UpdateCCHDate(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpdateBtn.Click
            For Each row As GridViewRow In FPIGv.Rows
                Dim reviewCheck As CheckBox = DirectCast(row.FindControl("ReviewCheck"), CheckBox)
                If (reviewCheck IsNot Nothing) AndAlso (reviewCheck.Checked) Then
                    Dim id As String = FPIGv.DataKeys(row.RowIndex).Value.ToString
                    CCHSql.UpdateParameters.Clear()
                    CCHSql.UpdateParameters.Add("User", UserLbl.Text)
                    CCHSql.UpdateParameters.Add("Id", id)
                    CCHSql.Update()
                End If
            Next

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
