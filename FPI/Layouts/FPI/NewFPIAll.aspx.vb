Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web.UI.WebControls
Imports System.Text
Imports System.Web.UI

Namespace Layouts.FPI

    Partial Public Class NewFPIAll
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Try
                Dim UserName As String = Context.User.Identity.Name.ToString
                UserLbl.Text = UserName.Substring(InStr(UserName, "\"))

            Catch ex As Exception
                errorlbl.Text = ex.ToString()
            End Try
            
        End Sub

        Protected Sub Review_clicked(ByVal sender As Object, ByVal e As EventArgs) Handles ReviewBtn.Click
            Try
                For Each row As GridViewRow In FPIGv.Rows
                    Dim reviewCheck As CheckBox = DirectCast(row.FindControl("ReviewCheck"), CheckBox)
                    If (reviewCheck IsNot Nothing) AndAlso (reviewCheck.Checked) Then
                        Dim id As String = FPIGv.DataKeys(row.RowIndex).Value.ToString
                        ReviewedSQL.UpdateParameters.Clear()
                        ReviewedSQL.UpdateParameters.Add("User", UserLbl.Text)
                        ReviewedSQL.UpdateParameters.Add("ClientId", id)
                        ReviewedSQL.Update()
                    End If
                Next
                FPIGv.DataBind()
            Catch ex As Exception
                Errorlbl.Text = ex.ToString()
            End Try
        End Sub

        Protected Sub ManagerDDL_DataBound(sender As Object, e As EventArgs)
            Try
                ManagerDDL.SelectedValue = UserLbl.Text.ToLower
            Catch ex As Exception
                Errorlbl.Text = "Current user not a manager"
            End Try
        End Sub

    End Class

End Namespace
