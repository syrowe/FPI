<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="VB" AutoEventWireup="true" CodeBehind="ReCalc.aspx.vb" Inherits="FPI.Layouts.FPI.ReCalc" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <table>
        <tr valign="top">
            <td>
                <asp:Label ID="Namelbl" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <asp:Button ID="ReCalcBtn" runat="server" Enabled="false" Text="Update" OnClick="SubmitRecalc" />
            </td>
        </tr>
    </table>
    
    <asp:Label ID="UserLabel" runat="server" Text="" Visible="false"></asp:Label>
    <asp:SqlDataSource ID="FPISql" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ML_DataConnectionString %>"
        SelectCommand="Select DetailName, datesent from FPIView where id=@id" 
        InsertCommand="FPI_Invoice" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" Type="String" QueryStringField="id" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="FPIdetailid" Type="String" QueryStringField="id" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Add Note
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Add Note
</asp:Content>
