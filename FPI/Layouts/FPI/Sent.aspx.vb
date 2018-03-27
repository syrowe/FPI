Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web.UI.WebControls
Imports System.Text
Imports System.Web

Namespace Layouts.FPI

    Partial Public Class Sent
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            UserLbl.Text = UserName.Substring(InStr(UserName, "\"))
        End Sub

        Protected Sub Review_clicked(ByVal sender As Object, ByVal e As EventArgs) Handles ReviewBtn.Click
            If DateTB.Text = "" Then
                Dim context As HttpContext = HttpContext.Current
                context.Response.Write("<script type='text/javascript'>alert('Please select a date');</script>")
                context.Response.Flush()
                context.Response.End()
            Else
                For Each row As GridViewRow In FPIGv.Rows
                    Dim reviewCheck As CheckBox = DirectCast(row.FindControl("ReviewCheck"), CheckBox)
                    If (reviewCheck IsNot Nothing) AndAlso (reviewCheck.Checked) Then
                        Dim id As String = FPIGv.DataKeys(row.RowIndex).Value.ToString
                        FPISQL.UpdateParameters.Clear()
                        FPISQL.UpdateParameters.Add("User", UserLbl.Text)
                        FPISQL.UpdateParameters.Add("date", DateTB.Text)
                        FPISQL.UpdateParameters.Add("Id", id)
                        FPISQL.Update()
                    End If
                Next
            End If
        End Sub
    End Class

End Namespace
