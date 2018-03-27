<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="FPIControl.aspx.vb" Inherits="FPI.Layouts.FPI.FPIControl" DynamicMasterPageFile="~masterurl/default.master" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <script type="text/javascript">

        function openDialog(DialogName, title) {
            var options = {
                url: DialogName,
                dialogReturnValueCallback: CloseWindowCallback,
                width: 400,
                height: 400,
                title: title
            };
            SP.UI.ModalDialog.showModalDialog(options);
            return false;
        }

        function CloseWindowCallback(dialogresult, returnValue) {
            {
                SP.UI.ModalDialog.RefreshPage(SP.UI.DialogResult.OK);
            }
        }
    </script>    
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<br />
<h2><asp:Label ID="Label1" runat="server" Text="FPI Control Page"></asp:Label></h2>
<br />
<table class="bordered">
    <tr valign="top">
        <td>
            <div>
                <table>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label6" runat="server" Text="Search for clients"></asp:Label></h3>           
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink5" NavigateUrl="~/admin/_Layouts/FPI/Review.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label2" runat="server" Text="Outstanding FPI Clients"></asp:Label> </h3>          
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink7" NavigateUrl="~/admin/_Layouts/FPI/MyFPIAll.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label5" runat="server" Text="Clients for Review"></asp:Label></h3>           
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink8" NavigateUrl="~/admin/_Layouts/FPI/NewFPIAll.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label7" runat="server" Text="Excluded clients"></asp:Label></h3>           
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink9" NavigateUrl="~/admin/_Layouts/FPI/ExcludedAll.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label9" runat="server" Text="Mark Clients as Sent"></asp:Label></h3>           
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink10" NavigateUrl="~/admin/_Layouts/FPI/Sent.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label3" runat="server" Text="Payments recevied"></asp:Label> </h3>          
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink2" NavigateUrl="~/admin/_Layouts/FPI/Payments.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h3><asp:Label ID="Label4" runat="server" Text="Notify CCH"></asp:Label></h3>           
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink3" NavigateUrl="~/admin/_Layouts/FPI/Notify.aspx" runat="server">Launch</asp:HyperLink>
                        </td>
                    </tr>
   
                </table>
            </div>
        </td>
        <td>
            <h3>&nbsp&nbsp&nbsp<asp:Label ID="Label8" runat="server" Text="Clients signed up (£)"></asp:Label></h3>
            <br />
            <asp:Chart ID="Chart2"  runat="server" Width="700px" Height="350px">
                <Series>
                    <asp:Series Name="Series 1">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
        </td>
    </tr>
    <tr>
        <td>
            <asp:DetailsView ID="DetailsView1" AutoGenerateRows="false" DataSourceID="TotalsSql" runat="server" Height="100px" Width="95%">
                <Fields>
                    <asp:BoundField DataField="Invoiced" HeaderText="Invoiced" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="Paid" HeaderText="Received" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="Submitted" HeaderText="Submitted to CCH" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="Number" HeaderText="Clients on board" ItemStyle-HorizontalAlign="Right" />
                </Fields>
            </asp:DetailsView>
        </td>
        <td>
            <asp:Button ID="YearBtn" runat="server" Visible="false" Text="Change FPI Year" OnClientClick="openDialog('NewYear.aspx', 'Select Year');return false;" />
        </td>
    </tr>
</table>

    <br />
    <br />

    <asp:Label ID="userlbl" runat="server" CssClass="user" Text=""></asp:Label>

    <asp:SqlDataSource ID="AmountSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="select manager, COUNT(manager) as Number,  CAST(SUM(Paid) as money) as Amount from FPIView where paid>0 group by manager" >
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="TotalsSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="select SUM(paid) as Paid, SUM(totalpremium) as Invoiced, (select COUNT(id) from FPIView where paid>0) as Number, (select COUNT(id) from FPIView where ISNULL(reportedon,'')<>'') as Submitted from FPIView" >
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="PermittedSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="Select count(parameter) as permitted from settings where parameter='FPIAdmin' and value like '%' + @user + '%'" >
        <SelectParameters>
            <asp:ControlParameter Name="user" Type="string" ControlID="UserLbl" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
FPI Control
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
FPI Control
</asp:Content>
