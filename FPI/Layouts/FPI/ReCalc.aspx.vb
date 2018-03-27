Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web
Imports System.Web.UI

Namespace Layouts.FPI

    Partial Public Class ReCalc
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            UserLabel.Text = UserName.Substring(InStr(UserName, "\"))
            Dim dvsql As DataView = DirectCast(FPISql.Select(DataSourceSelectArguments.Empty), DataView)
            If Not Page.IsPostBack Then
                Namelbl.Text = "Confirm Fee recalculation for " + CType(dvsql.Table.Rows(0)("DetailName"), String)
                If IsDBNull(dvsql.Table.Rows(0)("datesent")) Then
                    ReCalcBtn.Enabled = True
                End If
            End If

        End Sub

        Protected Sub SubmitRecalc(ByVal sender As Object, ByVal e As System.EventArgs) Handles ReCalcBtn.Click

            FPISql.Insert()
            Dim context As HttpContext = HttpContext.Current
            If HttpContext.Current.Request.QueryString("IsDlg") IsNot Nothing Then
                context.Response.Write("<script type='text/javascript'>window.frameElement.commonModalDialogClose(1, 'Ok');</script>")
                context.Response.Flush()
                context.Response.End()
            End If
        End Sub
    End Class

End Namespace
