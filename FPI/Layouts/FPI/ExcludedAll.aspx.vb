Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web.UI.WebControls
Imports System.Text

Namespace Layouts.FPI

    Partial Public Class ExcludedAll
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            UserLbl.Text = UserName.Substring(InStr(UserName, "\"))

        End Sub

        Protected Sub ManagerDDL_DataBound(sender As Object, e As EventArgs)
            ManagerDDL.SelectedValue = UserLbl.Text.ToLower
        End Sub

    End Class

End Namespace
