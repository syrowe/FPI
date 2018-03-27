<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="Payments.aspx.vb" Inherits="FPI.Layouts.FPI.Payments" DynamicMasterPageFile="~masterurl/default.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
  <asp:Table ID="Table1" runat="server">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="Label1" runat="server" Text="Start date:  "></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:TextBox ID="DateTB1" Text="" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="DateTB1" Format="dd/MM/yyyy"></asp:CalendarExtender>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="Label2" runat="server" Text="End date:  "></asp:Label>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Right">
                    <asp:TextBox ID="DateTB2" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="DateTB2" Format="dd/MM/yyyy"></asp:CalendarExtender>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Button ID="Button1" runat="server" Text="Apply" OnClientClick="return true;" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <br />
        <Sharepoint:SPGridView ID="SPGrid" runat="server" DataSourceID="CCHSql"  
            EnableModelValidation="True" AutoGenerateColumns="False" AllowFiltering="true" EnableViewState="false" FooterStyle-Font-Bold="true"
            AllowPaging="False" AllowSorting="True" AllowGrouping="false" UseAccessibleHeader="true" ShowFooter="true" Width="90%" BorderStyle="None" 
            CellPadding="1" CellSpacing="1" FooterStyle-BackColor="#FFF2D7">
           <Columns>
                <asp:BoundField DataField="client_code" HeaderText="Client Code" SortExpression="client_code"/>		
                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name"/>				
                <asp:BoundField DataField="PaidDate" HeaderText="Date Paid" SortExpression="PaidDate" DataFormatString="{0:d}" />               
                <asp:BoundField DataField="Paid" HeaderText="Amount" HeaderStyle-HorizontalAlign="Right" DataFormatString="{0:f2}" FooterStyle-HorizontalAlign="Right" SortExpression="Paid" ItemStyle-HorizontalAlign="Right"  />                
            </Columns>
        </Sharepoint:SPGridView>
    <br />
    <asp:Button ID="ExportBtn1" runat="server" Text="Export to Excel" />
    <br />

    <!--SQL for data -->
    <asp:SqlDataSource ID="CCHSql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>" 
        SelectCommand="FPI_payment" SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:ControlParameter Name="startdate" DefaultValue="" ControlID="DateTB1" PropertyName="text" />
            <asp:ControlParameter Name="enddate" DefaultValue="" ControlID="DateTB2" PropertyName="text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Payments    
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Payments
</asp:Content>
