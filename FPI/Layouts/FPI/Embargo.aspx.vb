Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web
Imports System.Web.UI

Namespace Layouts.FPI

    Partial Public Class Embargo
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            UserLabel.Text = UserName.Substring(InStr(UserName, "\"))
        End Sub

        Protected Sub SubmitEmbargo(ByVal sender As Object, ByVal e As System.EventArgs) Handles SubmitBtn.Click
            If EmbargoTb.Text.Length > 5 Then
                FPISql.Update()
                Dim context As HttpContext = HttpContext.Current
                If HttpContext.Current.Request.QueryString("IsDlg") IsNot Nothing Then
                    context.Response.Write("<script type='text/javascript'>window.frameElement.commonModalDialogClose(1, 'Ok');</script>")
                    context.Response.Flush()
                    context.Response.End()
                End If
            Else
                errorlbl.Text = "Reason must be at least 5 characters"
            End If

        End Sub
    End Class

End Namespace
