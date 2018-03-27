Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web
Imports System.Web.UI

Namespace Layouts.FPI

    Partial Public Class LogReceipt
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            UserLabel.Text = UserName.Substring(InStr(UserName, "\"))
            Dim dvsql As DataView = DirectCast(FPISql.Select(DataSourceSelectArguments.Empty), DataView)
            Dim PermittedDV As DataView = DirectCast(PermittedSQL.Select(DataSourceSelectArguments.Empty), DataView)
            If CType(PermittedDV.Table.Rows(0)("permitted"), Integer) = 0 Then
                SubmitBtn.Enabled = False
                DDBtn.Enabled = False
            Else
                SubmitBtn.Enabled = True
                DDBtn.Enabled = True
            End If
            If Not Page.IsPostBack Then
                AmountTb.Text = CType(dvsql.Table.Rows(0)("amount"), String)
                NarTb.Text = CType(dvsql.Table.Rows(0)("name"), String)
                DateTb.Text = CType(dvsql.Table.Rows(0)("date"), String)
            End If

        End Sub

        Protected Sub SubmitReceipt(ByVal sender As Object, ByVal e As System.EventArgs) Handles SubmitBtn.Click

            FPISql.Insert()
            Dim context As HttpContext = HttpContext.Current
            If HttpContext.Current.Request.QueryString("IsDlg") IsNot Nothing Then
                context.Response.Write("<script type='text/javascript'>window.frameElement.commonModalDialogClose(1, 'Ok');</script>")
                context.Response.Flush()
                context.Response.End()
            End If
        End Sub

        Protected Sub DirectDebit(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDBtn.Click

            FPISql.Update()
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
