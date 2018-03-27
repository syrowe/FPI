Imports System
Imports Microsoft.SharePoint
Imports Microsoft.SharePoint.WebControls
Imports System.Web.UI.DataVisualization.Charting
Imports System.Web.UI

Namespace Layouts.FPI

    Partial Public Class FPIControl
        Inherits LayoutsPageBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
            Dim UserName As String = Context.User.Identity.Name.ToString
            userlbl.Text = UserName.Substring(InStr(UserName, "\"))

            'access to items based on username
            Dim PermittedDV As DataView = DirectCast(PermittedSQL.Select(DataSourceSelectArguments.Empty), DataView)
            If CType(PermittedDV.Table.Rows(0)("permitted"), Integer) = 0 Then
                YearBtn.Visible = False
            Else
                YearBtn.Visible = True
            End If

            'Charting
            'set chart data source - the data source must implement IEnumerable
            Chart2.DataSource = AmountSql

            ' Set series members names for the X and Y values 
            Chart2.Series("Series 1").XValueMember = "Manager"
            Chart2.Series("Series 1").YValueMembers = "Amount"

            Chart2.Series("Series 1").ChartType = SeriesChartType.Column
            Chart2.ChartAreas("ChartArea1").AxisX.Interval = 1
            Chart2.Series("Series 1").ToolTip = "#VALY{C}"
            ' Data bind to the selected data source
            Chart2.DataBind()
        End Sub


    End Class

End Namespace
