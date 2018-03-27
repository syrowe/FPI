<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="LogReceipt.aspx.vb" Inherits="FPI.Layouts.FPI.LogReceipt" DynamicMasterPageFile="~masterurl/default.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <table>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Date: "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="DateTb" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="DateTB" Format="dd/MM/yyyy"></asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" Text="Received from: "></asp:Label>    
            </td>
            <td>
                <asp:TextBox ID="NarTb" runat="server"></asp:TextBox>    
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Enter Amount: "></asp:Label>    
            </td>
            <td>
                <asp:TextBox ID="AmountTb" runat="server"></asp:TextBox>    
            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="SubmitBtn" runat="server" Text="Submit" Enabled="false" OnClick="SubmitReceipt" />
    <br />
    <br />
    <asp:Button ID="DDBtn" runat="server" Text="Direct Debit" Enabled="false" OnClick="DirectDebit" />

    <asp:Label ID="UserLabel" runat="server" Text="" Visible="false"></asp:Label>
    <asp:SqlDataSource ID="FPISql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="Select Convert(Decimal(10,2), Totalpremium-paid) as amount, lead_name as name, convert(varchar, getdate(), 103) as date from FPIView where id=@id" 
        InsertCommand="FPI_LogReceipt" InsertCommandType="StoredProcedure"
        UpdateCommand="FPI_DirectDebit" UpdateCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:QueryStringParameter Name="id" Type="String" QueryStringField="id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="id" Type="String" QueryStringField="id" />
            <asp:ControlParameter Name="user" Type="string" ControlID="UserLabel" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="id" Type="String" QueryStringField="id" />
            <asp:ControlParameter Name="amount" Type="String" ControlID="AmountTB" />
            <asp:ControlParameter Name="narrative" Type="String" ControlID="NarTB" />
            <asp:ControlParameter Name="date" Type="String" ControlID="DateTB" />
            <asp:ControlParameter Name="user" Type="string" ControlID="UserLabel" />
        </InsertParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="PermittedSQL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="Select count(parameter) as permitted from settings where parameter='FPIAdmin' and value like '%' + @user + '%'" >
        <SelectParameters>
            <asp:ControlParameter Name="user" Type="string" ControlID="UserLabel" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Log Receipt
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Log Receipt
</asp:Content>
