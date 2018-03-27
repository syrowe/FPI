Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web.UI

Namespace Layouts

    Partial Public Class NewYear
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

            'get current user
            Dim UserName As String = Context.User.Identity.Name.ToString
            Userlbl.Text = UserName.Substring(InStr(UserName, "\"))

            'display current FPI Year only if not postback otherwise it won't update after button click
            If Not IsPostBack Then
                Dim FPIDV As DataView = DirectCast(FPISql.Select(DataSourceSelectArguments.Empty), DataView)
                FPITb.Text = CType(FPIDV.Table.Rows(0)(0), String)
                FPIYearlbl.Text = CType(FPIDV.Table.Rows(0)(0), String)
            End If

            'work out whether current user is "qualified"
            Dim PermittedDV As DataView = DirectCast(PermittedSQL.Select(DataSourceSelectArguments.Empty), DataView)
            If CType(PermittedDV.Table.Rows(0)("permitted"), Integer) = 0 Then
                SubmitBtn.Visible = False
            Else
                SubmitBtn.Visible = True
            End If
        End Sub

        Protected Sub UpdateCCHDate(ByVal sender As Object, ByVal e As System.EventArgs) Handles SubmitBtn.Click
            'on click run the sql update.
            FPISql.Update()
        End Sub

    End Class

End Namespace
